//
//  AnimalPhotoRequest.swift
//  AnimalAtlas
//
//  Created by Christopher Minarto  on 17/01/24.
//

import Foundation

struct AnimalPhotoRequest: APIRequest {
    var pathname: String {"/search?query=\(animalName)&per_page=10"}
    var animalName: String?
    var method: String {"GET"}
    typealias Response = AnimalPhotoResponse
}
