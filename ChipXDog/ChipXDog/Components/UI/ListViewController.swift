//
//  ViewController.swift
//  ChipXDog
//
//  Created by Joe on 28/05/2022.
//

import UIKit

final class ListViewController: UITableViewController {
    var dogAPI = DogAPI()
    private var dogs = [Breed]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Chip x Dog API"
        fetchList()
    }
    
    func fetchList() {
        dogAPI.dogService.fetchDogList { result in
            switch result {
            case .success(let data):
                do {
                    let list = try JSONDecoder().decode(Dogs.self, from: data)
                    print("----> Unaltered List: \(list)")
                    let mirrorList = Mirror(reflecting: list.message)
//                    var subBreeds = [String]()
                    var breeds = [String]()
                    for (key, value) in mirrorList.children {
                        guard let key = key else { return }
                        breeds.append("\(key.capitalized)")
                        guard let value = value as? [Any] else { return }
                        if value.isEmpty {
                            self.dogs.append(Breed(type: key))
                        } else {
                            for subBreed in value {
                                guard let subBreed = subBreed as? String else { return }
                                self.dogs.append(Breed(type: key, subBreed: subBreed))
                            }
                        }
                    }
//                    print(subBreeds)
                    print("----> Breeds Count: \(breeds.count)")
                    print("----> Sub-breeds Count: \(self.dogs.count)")
                    
                } catch {
                    print("Error Decoding")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("----> num Dog Count: \(dogs.count)")
        return dogs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Dog", for: indexPath)
        let dog = dogs[indexPath.row]
        if dog.subBreed == nil {
            cell.textLabel?.text = dog.type.capitalized
            cell.detailTextLabel?.text = ""
        } else {
            cell.textLabel?.text = dog.type.capitalized
            cell.detailTextLabel?.text = dog.subBreed?.capitalized
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let dvc = storyboard?.instantiateViewController(identifier: "DetailView") as? DetailViewController {
            dvc.dog = dogs[indexPath.row]
            navigationController?.pushViewController(dvc, animated: true)
        }
        
    }
}

