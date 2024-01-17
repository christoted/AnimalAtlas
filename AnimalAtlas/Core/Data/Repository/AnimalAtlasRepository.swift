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
    func getAnimalPhoto(animalName: String) ->
        Observable<AnimalPhotoResponse>
}

class AnimalAtlasRepository: AnimalAtlasRepositoryProtocol {
    let animalAtlasRemoteDataSource: AnimalAtlasRemoteDataSource
    
    init(animalAtlasRemoteDataSource: AnimalAtlasRemoteDataSource) {
        self.animalAtlasRemoteDataSource = animalAtlasRemoteDataSource
    }
    
    func getAnimalData(animalName: String) -> Observable<[AnimalListResponse]> {
        return animalAtlasRemoteDataSource.getAnimalData(animalName: animalName)
    }
    
    func getAnimalPhoto(animalName: String) -> Observable<AnimalPhotoResponse> {
        return animalAtlasRemoteDataSource.getAnimalPhoto(animalName: animalName)
    }
}
