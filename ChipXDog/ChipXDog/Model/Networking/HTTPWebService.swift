//
//  HTTPWebService.swift
//  ChipXDog
//
//  Created by Joe on 02/06/2022.
//

import Foundation

public protocol HTTPWebService {
    var session: URLSession { get }
    var baseURL: String { get }
}

extension HTTPWebService {
    func call(endpoint: APICall, method: String = "GET", completion: @escaping (_ result: Result<Data, Error>) -> Void) {
        do {
            let request = try endpoint.createURLRequest(baseURL: baseURL, method: method)
            // Make the request
            session.startData(request) { result in
                completion(result)
            }
        } catch (let error) {
            completion(.failure(HTTPError.other(error)))
        }
    }
}
