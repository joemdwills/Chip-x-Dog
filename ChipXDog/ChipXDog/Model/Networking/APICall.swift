//
//  APICall.swift
//  ChipXDog
//
//  Created by Joe on 02/06/2022.
//

import Foundation

protocol APICall {
    var path: String { get }
}

extension APICall {
    func createURL(baseURL: String) -> URL? {
        return URL(string: baseURL + path)
    }
    
    func createURLRequest(baseURL: String, method: String = "GET") throws -> URLRequest {
        guard let url = createURL(baseURL: baseURL) else {
            throw HTTPError.invalidRequest
        }
        
        return createURLRequest(url: url, method: method)
    }
    
    private func createURLRequest(url: URL, method: String) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        return request
    }
}
