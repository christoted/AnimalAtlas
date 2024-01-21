//
//  AnimalFavoriteViewModel.swift
//  AnimalAtlas
//
//  Created by Christopher Minarto  on 18/01/24.
//

import Foundation
import RxSwift
import RxCocoa

class AnimalFavoriteViewModel {
    private let disposeBag = DisposeBag()
    private let animalAtlasRepository: AnimalAtlasRepositoryProtocol
    
    private let animalPhotoLocaleSubject = PublishSubject<[AnimalAtlasModel]>()
    public var animalPhotoLocaleSubjectDriver: Driver<[AnimalAtlasModel]> {
       return animalPhotoLocaleSubject.asDriverOnErrorJustComplete()
    }
    
    private let animalPhotoFilteredLocaleSubject = PublishSubject<[AnimalAtlasModel]>()
    public var animalPhotoFilteredLocaleSubjectDriver: Driver<[AnimalAtlasModel]> {
       return animalPhotoLocaleSubject.asDriverOnErrorJustComplete()
    }
    
    init() {
        animalAtlasRepository = ManualInjection.shared.provideAnimalAtlasRepository()
    }
    
    func getAnimalPhotoLiked() {
        animalAtlasRepository.getImage().subscribe(onNext: {[weak self] animalImagesLocal in
            self?.animalPhotoLocaleSubject.onNext(animalImagesLocal)
        }, onError: { err in
            print(">> error fetch")
        }).disposed(by: disposeBag)
    }
    
    func filterAnimalImage(animalName: String) {
        var animalModels: [AnimalAtlasModel] = []
        animalAtlasRepository.getImage().subscribe(onNext: {[weak self] animalImagesLocal in
            self?.animalPhotoLocaleSubject.onNext(animalImagesLocal)
            animalImagesLocal.forEach { animalModel in
                if animalModel.animalType == animalName {
                    animalModels.append(animalModel)
                }
            }
            self?.animalPhotoLocaleSubject.onNext(animalModels)
        }, onError: { err in
            print(">> error fetch")
        }).disposed(by: disposeBag)
    }
    
}
