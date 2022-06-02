//
//  ViewController.swift
//  ChipXDog
//
//  Created by Joe on 28/05/2022.
//

import UIKit

final class ListViewController: UITableViewController {
    var dogAPI = DogAPI()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        fetchList()
    }
    
    func fetchList() {
        dogAPI.dogService.fetchDogList { result in
            switch result {
            case .success(let data):
                do {
                    let list = try JSONDecoder().decode(Dogs.self, from: data)
                    print("-----> Unaltered List: \(list)")
                    let mirrorList = Mirror(reflecting: list.message)
                    var subBreeds = [String]()
                    var breeds = [String]()
                    for (key, value) in mirrorList.children {
                        guard let key = key else { return }
                        breeds.append("\(key.capitalized)")
                        guard let value = value as? [Any] else { return }
                        if value.isEmpty {
                            subBreeds.append("\(key.capitalized)")
                        } else {
                            for subBreed in value {
                                guard let subBreed = subBreed as? String else { return }
                                subBreeds.append("\(subBreed.capitalized) \(key.capitalized)")
                            }
                        }
                    }
                    print(subBreeds)
                    print("----> Breeds Count: \(breeds.count)")
                    print("----> Sub-breeds Count: \(subBreeds.count)")
                    
                } catch {
                    print("Error Decoding")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

