//
//  DogService.swift
//  ChipXDog
//
//  Created by Joe on 02/06/2022.
//

import Foundation

protocol DOGAPIService: HTTPWebService {
    func fetchDogList(completion: @escaping (_ result: Result<Data, Error>) -> Void)
    func fetchSingleDogImage(breed: Breed, completion: @escaping (_ result: Result<Data, Error>) -> Void)
    func fetchDogImages(breed: Breed, completion: @escaping (_ result: Result<Data, Error>) -> Void)
}

public struct DogService: DOGAPIService {
    
    enum API: APICall {
        case fetchDogList
        case fetchSingleDogImage(breed: Breed)
        case fetchDogImages(breed: Breed)
        
        var path: String {
            switch self {
            case .fetchDogList:
                return "/breeds/list/all"
            case .fetchSingleDogImage(let breed):
                guard let subBreed = breed.subBreed else {
                    return "/breed/\(breed.type)/images"
                }
                return "/breed/\(breed.type)/\(subBreed)/images"
            case .fetchDogImages(let breed):
                guard let subBreed = breed.subBreed else {
                    return "/breed/\(breed.type)/images"
                }
                return "/breed/\(breed.type)/\(subBreed)/images"
            }
        }
    }
    
    public var session: URLSession
    public var baseURL: String = "https://dog.ceo/api"
    
    func fetchDogList(completion: @escaping (_ result: Result<Data, Error>) -> Void) {
        call(endpoint: API.fetchDogList) { result in
            completion(result)
        }
    }
    
    func fetchSingleDogImage(breed: Breed, completion: @escaping (_ result: Result<Data, Error>) -> Void) {
        call(endpoint: API.fetchSingleDogImage(breed: breed)) { result in
            completion(result)
        }
    }
    
    func fetchDogImages(breed: Breed, completion: @escaping (_ result: Result<Data, Error>) -> Void) {
        call(endpoint: API.fetchDogImages(breed: breed)) { result in
            completion(result)
        }
    }
}
