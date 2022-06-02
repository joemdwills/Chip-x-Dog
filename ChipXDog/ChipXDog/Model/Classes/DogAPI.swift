//
//  DogAPI.swift
//  ChipXDog
//
//  Created by Joe on 02/06/2022.
//

import Foundation

public class DogAPI {
    public let session: URLSession
    
    public init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    public lazy private(set) var dogService = DogService(session: session)
}
