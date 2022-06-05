//
//  DetailCollectionViewModel.swift
//  ChipXDog
//
//  Created by Joe on 05/06/2022.
//

import Combine
import Foundation
import UIKit

class DetailCollectionViewModel {
    private var dogAPI = DogAPI()
    var dog: Breed
    var imageURLS = [String]()
    var images = [UIImage]()
    var title: String {
        get {
            let dog = dog
            if let subBreed = dog.subBreed {
                return "\(subBreed) \(dog.type)"
            } else {
                return "\(dog.type)"
            }
        }
    }
    
    init(dog: Breed) {
        self.dog = dog
    }
    
    func fetchImageURLS(completion: @escaping () -> Void) {
        dogAPI.dogService.fetchDogImages(breed: dog) { [self] result in
            switch result {
            case .success(let data):
                decodeResponse(data: data)
                loadImages(urls: imageURLS) {
                    completion()
                }
            case .failure(let error):
                // Would use Combine here to set an isAlertShown property to true to trigger an Alert in the view of a fetching/netowrk decode error.
                print(error.localizedDescription)
            }
        }
    }
    
    func decodeResponse(data: Data) {
        do {
            let json = try JSONDecoder().decode(Images.self, from: data)
            imageURLS = json.message
        } catch {
            print("Error Decoding")
            // Would use Combine here to set an isAlertShown property to true, to trigger an Alert in the view of a decode error.
        }
    }
    
    func loadImages(urls: [String], completion: @escaping () -> Void) {
        var count = 0
        while count < 10 {
            guard let imageURL = urls.randomElement() else { return }
            guard let url = URL(string: imageURL) else { return }
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    images.append(image)
                }
            }
            count += 1
        }
        completion()
    }
}
