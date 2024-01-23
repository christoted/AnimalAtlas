//
//  AnimalDetailViewModel.swift
//  AnimalAtlas
//
//  Created by Christopher Minarto  on 17/01/24.
//

import RxSwift
import RxCocoa

class AnimalDetailViewModel {
    
    private let disposeBag = DisposeBag()
    private let animalAtlasRepository: AnimalAtlasRepositoryProtocol
    
    private let animalDetailSubject = PublishSubject<AnimalListResponse>()
    public var animalDetailSubjectDriver: Driver<AnimalListResponse> {
       return animalDetailSubject.asDriverOnErrorJustComplete()
    }
    
    private let animalErrorDetailSubject = PublishSubject<String>()
    public var animalErrorDetailSubjectDriver: Driver<String> {
       return animalErrorDetailSubject.asDriverOnErrorJustComplete()
    }
    
    private let animalPhotoSubject = PublishSubject<AnimalPhotoResponse>()
    public var animalPhotoSubjectDriver: Driver<AnimalPhotoResponse> {
       return animalPhotoSubject.asDriverOnErrorJustComplete()
    }
    
    private let animalPhotoLocaleSubject = PublishSubject<[AnimalAtlasModel]>()
    public var animalPhotoLocaleSubjectDriver: Driver<[AnimalAtlasModel]> {
       return animalPhotoLocaleSubject.asDriverOnErrorJustComplete()
    }
    
    init() {
        animalAtlasRepository = ManualInjection.shared.provideAnimalAtlasRepository()
    }
    
    func getCombineAnimalData(animalName: String) {
        Observable.zip(animalAtlasRepository.getAnimalData(animalName: animalName), animalAtlasRepository.getAnimalPhoto(animalName: animalName)).subscribe(onNext: { [weak self] animalData, animalPhoto in
            if !animalData.isEmpty {
                let specificAnimalName = animalData.filter { $0.name == animalName}
                if let specificAnimalNameSafe = specificAnimalName[safe: 0] {
                    self?.animalDetailSubject.onNext(specificAnimalNameSafe)
                } else {
                    if let dataSafe = animalData[safe: 0] {
                        self?.animalDetailSubject.onNext(dataSafe)
                    }
                }
            }
            self?.animalPhotoSubject.onNext(animalPhoto)
        }, onError: { err in
            
        }).disposed(by: disposeBag)
    }
    
    func getAnimalData(animalName: String) {
        animalAtlasRepository.getAnimalData(animalName: animalName).subscribe(onNext: { [weak self] data in
            if !data.isEmpty {
                let specificAnimalName = data.filter { $0.name == animalName}
                if let specificAnimalNameSafe = specificAnimalName[safe: 0] {
                    self?.animalDetailSubject.onNext(specificAnimalNameSafe)
                } else {
                    guard let dataSafe = data[safe: 0] else { return }
                    self?.animalDetailSubject.onNext(dataSafe)
                }
             
            }
        }, onError: { [weak self] err in
                self?.animalErrorDetailSubject.onNext(err.localizedDescription)
        }, onCompleted: {
           
        }).disposed(by: disposeBag)
    }
    
    func getAnimalPhoto(animalName: String) {
        animalAtlasRepository.getAnimalPhoto(animalName: animalName).subscribe(onNext: { [weak self] data in
            self?.animalPhotoSubject.onNext(data)
        }, onError: { error in
            
        }).disposed(by: disposeBag)
    }
    
    // Locale
    func saveAnimalPhoto(animalModel: AnimalAtlasModel) {
        animalAtlasRepository.saveImage(model: animalModel).subscribe(onNext: { isSuccess in
        }, onError: { err in
        }).disposed(by: disposeBag)
    }
    func deleteAnimalPhoto(animalId: Int) {
        animalAtlasRepository.deleteImage(animalId: animalId).subscribe(onNext: { isSuccess in
        }, onError: { err in
        }).disposed(by: disposeBag)
    }
    func getAnimalPhotoLiked() {
        animalAtlasRepository.getImage().subscribe(onNext: {[weak self] animalImagesLocal in
            self?.animalPhotoLocaleSubject.onNext(animalImagesLocal)
        }, onError: { err in
        }).disposed(by: disposeBag)
    }
}
