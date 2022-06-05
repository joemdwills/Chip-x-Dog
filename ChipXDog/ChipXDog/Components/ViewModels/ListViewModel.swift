//
//  ListViewModel.swift
//  ChipXDog
//
//  Created by Joe on 05/06/2022.
//

import Foundation
import UIKit

class ListViewModel {
    private var dogAPI = DogAPI()
    var dogs = [Breed]()
    
    let decoder = JSONDecoder()
    
    func fetchDogList(completion: @escaping () -> (Void)) {
        dogAPI.dogService.fetchDogList { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.decodeResponse(data: data)
            case .failure(let error):
                // Present UIAlertController
                print(error.localizedDescription)
            }
            completion()
        }
    }
    
    func decodeResponse(data: Data) {
        do {
            let list = try decoder.decode(Dogs.self, from: data)
            print("----> Unaltered List: \(list)")
            let mirrorList = Mirror(reflecting: list.message)
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
            print("----> Breeds Count: \(breeds.count)")
            print("----> Sub-breeds Count: \(self.dogs.count)")
        } catch {
            // Present UIAlertController
            print("Error Decoding")
        }
    }
}
