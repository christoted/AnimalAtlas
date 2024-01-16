//
//  ManualInjection.swift
//  AnimalAtlas
//
//  Created by Christopher Minarto  on 16/01/24.
//

import Foundation

class ManualInjection {
    
    static let shared = ManualInjection()
    
    func provideAnimalAtlasRepository() -> AnimalAtlasRepositoryProtocol {
        let remoteDataSource = AnimalAtlasRemoteDataSource()
        return AnimalAtlasRepository(animalAtlasRemoteDataSource: remoteDataSource)
    }
}
