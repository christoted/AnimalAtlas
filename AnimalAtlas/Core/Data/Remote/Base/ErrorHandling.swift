//
//  ErrorHandling.swift
//  AnimalAtlas
//
//  Created by Christopher Minarto  on 16/01/24.
//

import Foundation

enum APIError: Error {
    case requestFailed
    case invalidResponse
}

enum CoreDataError: Error {
    case failedToFetch
    case failedToDelete
}
