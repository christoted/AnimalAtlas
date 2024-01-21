//
//  AnimalAtlasRepository.swift
//  AnimalAtlas
//
//  Created by Christopher Minarto  on 16/01/24.
//

import Foundation
import RxSwift

protocol AnimalAtlasRepositoryProtocol {
    // Remote
    func getAnimalData(animalName: String) -> Observable<[AnimalListResponse]>
    func getAnimalPhoto(animalName: String) ->
        Observable<AnimalPhotoResponse>
    // Locale
    func saveImage(model: AnimalAtlasModel) -> Observable<Bool>
    func getImage() -> Observable<[AnimalAtlasModel]>
    func deleteImage(animalId: Int) -> Observable<Bool>
}

class AnimalAtlasRepository: AnimalAtlasRepositoryProtocol {
    let animalAtlasRemoteDataSource: AnimalAtlasRemoteDataSource
    let animalAtlasLocaleDataSource: AnimalAtlasLocaleDataSource
    
    init(animalAtlasRemoteDataSource: AnimalAtlasRemoteDataSource,animalAtlasLocaleDataSource: AnimalAtlasLocaleDataSource ) {
        self.animalAtlasRemoteDataSource = animalAtlasRemoteDataSource
        self.animalAtlasLocaleDataSource = animalAtlasLocaleDataSource
    }
    
    func getAnimalData(animalName: String) -> Observable<[AnimalListResponse]> {
        return animalAtlasRemoteDataSource.getAnimalData(animalName: animalName)
    }
    
    func getAnimalPhoto(animalName: String) -> Observable<AnimalPhotoResponse> {
        return animalAtlasRemoteDataSource.getAnimalPhoto(animalName: animalName)
    }
    
    func saveImage(model: AnimalAtlasModel) -> Observable<Bool> {
        return animalAtlasLocaleDataSource.saveImage(model: model)
    }
    
    func getImage() -> Observable<[AnimalAtlasModel]> {
        return animalAtlasLocaleDataSource.getImage()
    }
    
    func deleteImage(animalId: Int) -> Observable<Bool> {
        return animalAtlasLocaleDataSource.deleteImage(animalId: animalId)
    }
}
