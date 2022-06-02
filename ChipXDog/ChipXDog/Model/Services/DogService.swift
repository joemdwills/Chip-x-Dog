//
//  DogService.swift
//  ChipXDog
//
//  Created by Joe on 02/06/2022.
//

import Foundation

protocol DOGAPIService: HTTPWebService {
    func fetchDogList(completion: @escaping (_ result: Result<Data, Error>) -> Void)
    func fetchSingleDogImage(breed: String, subBreed: String, completion: @escaping (_ result: Result<Data, Error>) -> Void)
    func fetchDogImages(breed: String, subBreed: String, completion: @escaping (_ result: Result<Data, Error>) -> Void)
}

public struct DogService: DOGAPIService {
    
    public enum API: APICall {
        case fetchDogList
        case fetchSingleDogImage(breed: String, subBreed: String)
        case fetchDogImages(breed: String, subBreed: String)
        
        var path: String {
            switch self {
            case .fetchDogList:
                return "/breeds/list/all"
            case .fetchSingleDogImage(let breed, let subBreed):
                return "/breed/\(breed)/\(subBreed)/images/random"
            case .fetchDogImages(let breed, let subBreed):
                return "/breed/\(breed)/\(subBreed)/images"
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
    
    func fetchSingleDogImage(breed: String, subBreed: String, completion: @escaping (_ result: Result<Data, Error>) -> Void) {
        call(endpoint: API.fetchSingleDogImage(breed: breed, subBreed: subBreed)) { result in
            completion(result)
        }
    }
    
    func fetchDogImages(breed: String, subBreed: String, completion: @escaping (_ result: Result<Data, Error>) -> Void) {
        call(endpoint: API.fetchDogImages(breed: breed, subBreed: subBreed)) { result in
            completion(result)
        }
    }
}
