//
//  AnimalAtlasRepository.swift
//  AnimalAtlas
//
//  Created by Christopher Minarto  on 16/01/24.
//

import Foundation
import RxSwift

protocol AnimalAtlasRepositoryProtocol {
    func getAnimalData(animalName: String) -> Observable<[AnimalListResponse]>
}

class AnimalAtlasRepository: AnimalAtlasRepositoryProtocol {
    
    let animalAtlasRemoteDataSource: AnimalAtlasRemoteDataSource
    
    init(animalAtlasRemoteDataSource: AnimalAtlasRemoteDataSource) {
        self.animalAtlasRemoteDataSource = animalAtlasRemoteDataSource
    }
    
    func getAnimalData(animalName: String) -> Observable<[AnimalListResponse]> {
        return animalAtlasRemoteDataSource.getAnimalData(animalName: animalName)
    }
}
