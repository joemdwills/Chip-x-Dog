//
//  URLSession+.swift
//  ChipXDog
//
//  Created by Joe on 02/06/2022.
//

import Foundation

extension URLSession {
    func startData(_ request: URLRequest, completion: @escaping (_ result: Result<Data, Error>) -> Void) {
        self.dataTask(with: request) { data, response, error in
            if let response = response as? HTTPURLResponse {
                let status = HTTPStatus(code: response.statusCode)
                
                if status == .unauthorized {
                    completion(.failure(HTTPError.unauthorized))
                } else if status.category == .success,
                    let data = data {
                    completion(.success(data))
                } else {
                    completion(.failure(HTTPError.serverResponse(status, data)))
                }
            } else if let error = error {
                if let nsError = error as NSError?,
                    nsError.code == HTTPError.noNetwork.code {
                    completion(.failure(HTTPError.noNetwork))
                } else if let nsError = error as NSError?,
                    nsError.code == HTTPError.timeout.code {
                    completion(.failure(HTTPError.timeout))
                } else if let httpError = error as? HTTPError {
                    completion(.failure(httpError))
                } else {
                    completion(.failure(HTTPError.other(error)))
                }
            } else {
                completion(.failure(HTTPError.httpError))
            }
        }.resume()
    }
}
