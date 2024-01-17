//
//  AnimalListRequest.swift
//  AnimalAtlas
//
//  Created by Christopher Minarto  on 16/01/24.
//

import Foundation

struct AnimalListRequest: APIRequest {
    var pathname: String {"/animals?name=\(animalName ?? "")"}
    var animalName: String?
    var method: String {"GET"}
    typealias Response = [AnimalListResponse]
}
