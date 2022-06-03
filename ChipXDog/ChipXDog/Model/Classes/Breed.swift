//
//  Breed.swift
//  ChipXDog
//
//  Created by Joe on 03/06/2022.
//

import Foundation

struct Breed {
    let type: String
    let subBreed: String?
    
    init(type: String) {
        self.type = type
        self.subBreed = nil
    }
    
    init(type: String, subBreed: String?) {
        self.type = type
        self.subBreed = subBreed
    }
}
