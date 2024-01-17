//
//  AnimalAtlasRemoteDataSource.swift
//  AnimalAtlas
//
//  Created by Christopher Minarto  on 16/01/24.
//

import Foundation
import RxSwift

protocol AnimalAtlasRemoteDataSourceProtocol {
    func getAnimalData(animalName: String) -> Observable<[AnimalListResponse]>
    func getAnimalPhoto(animalName: String) ->
        Observable<AnimalPhotoResponse>
}

class AnimalAtlasRemoteDataSource: AnimalAtlasRemoteDataSourceProtocol {
    
    func getAnimalData(animalName: String) -> Observable<[AnimalListResponse]> {
        let request = AnimalListRequest(animalName: animalName)
        return APIClient().fetch(request: request, baseURL: Constant.animalDataBaseURL)
    }
    
    func getAnimalPhoto(animalName: String) -> Observable<AnimalPhotoResponse> {        
        let request = AnimalPhotoRequest(animalName: animalName)
        return APIClient().fetch(request: request, baseURL: Constant.animalPhotoBaseURL)
    }
}
