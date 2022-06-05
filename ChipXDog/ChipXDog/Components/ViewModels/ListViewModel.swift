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
                // Would use Combine here to set an isAlertShown property to true to trigger an Alert in the view of a fetching/netowrk decode error.
                print(error.localizedDescription)
            }
            completion()
        }
    }
    
    func decodeResponse(data: Data) {
        do {
            let list = try decoder.decode(Dogs.self, from: data)
            let mirrorList = Mirror(reflecting: list.message)
            for (key, value) in mirrorList.children {
                guard let key = key else { return }
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
        } catch {
            // Would use Combine here to set an isAlertShown property to true, to trigger an Alert in the view of a decode error.
            print("Error Decoding")
        }
    }
}
