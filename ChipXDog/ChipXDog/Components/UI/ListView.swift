//
//  ViewController.swift
//  ChipXDog
//
//  Created by Joe on 28/05/2022.
//

import UIKit

final class ListView: UITableViewController {
    private var viewModel = ListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chip x Dog API"
        viewModel.fetchDogList {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("----> num Dog Count: \(viewModel.dogs.count)")
        return viewModel.dogs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Dog", for: indexPath)
        let dog = viewModel.dogs[indexPath.row]
        if dog.subBreed == nil {
            cell.textLabel?.text = dog.type.capitalized
            cell.detailTextLabel?.text = ""
            cell.accessibilityLabel = "Dog Breed, \(dog.type)"
        } else {
            cell.textLabel?.text = dog.type.capitalized
            cell.detailTextLabel?.text = dog.subBreed!.capitalized
            cell.accessibilityLabel = "Dog Breed, \(dog.subBreed! + dog.type)"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let dvc = storyboard?.instantiateViewController(identifier: String(describing: DetailCollectionView.self)) as? DetailCollectionView {
            dvc.viewModel = DetailCollectionViewModel(dog: viewModel.dogs[indexPath.row])
            navigationController?.pushViewController(dvc, animated: true)
        }
    }
}

