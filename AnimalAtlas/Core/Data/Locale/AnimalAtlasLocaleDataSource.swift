//
//  AnimalAtlasLocaleDataSource.swift
//  AnimalAtlas
//
//  Created by Christopher Minarto  on 20/01/24.
//

import CoreData
import UIKit
import RxSwift

protocol AnimalAtlasLocaleDataSourceProtocol {
    func saveImage(model: AnimalAtlasModel) -> Observable<Bool>
    func getImage() -> Observable<[AnimalAtlasModel]>
    func deleteImage(animalId: Int) -> Observable<Bool>
}

class AnimalAtlasLocaleDataSource: AnimalAtlasLocaleDataSourceProtocol {
    func saveImage(model: AnimalAtlasModel) -> Observable<Bool> {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return Observable.just(false) }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let newItem = AnimalAtlasEntity(context: managedContext)
        newItem.animalId = Int32(model.animalId)
        newItem.animalName = model.animalName
        newItem.animalImage = model.animalImage
        newItem.animalType = model.animalType
        
        return Observable<Bool>.create { observer in
            do {
               try managedContext.save()
               observer.onNext(true)
               print("Data saved")
            } catch let error as NSError {
                print(error)
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    func getImage() -> Observable<[AnimalAtlasModel]> {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return Observable<[AnimalAtlasModel]>.create { observer in
            var animalAtlasModels: [AnimalAtlasModel] = []
            do {
                let items = try context.fetch(AnimalAtlasEntity.fetchRequest()) as! [AnimalAtlasEntity]
                for item in items {
                    guard let animalName = item.animalName, let animalType = item.animalType, let animalImage = item.animalImage else { return Observable<[AnimalAtlasModel]>.just([]) as! Disposable }
                    let model = AnimalAtlasModel(animalId: Int(item.animalId), animalName: animalName, animalType: animalType, animalImage: animalImage)
                    animalAtlasModels.append(model)
                }
                observer.onNext(animalAtlasModels)
            } catch {
                print("Fetch failed")
                observer.onError(CoreDataError.failedToFetch)
            }
            return Disposables.create()
        }
    }
    
    func deleteImage(animalId: Int) -> Observable<Bool> {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return Observable<Bool>.create { observer in
            do {
                let items = try context.fetch(AnimalAtlasEntity.fetchRequest()) as! [AnimalAtlasEntity]
                items.forEach { entity in
                    if entity.animalId == animalId {
                        context.delete(entity)
                        (UIApplication.shared.delegate as! AppDelegate).saveContext()
                    }
                }
                observer.onNext(true)
            } catch {
                print("Delete failed")
                observer.onError(CoreDataError.failedToDelete)
            }
            return Disposables.create()
        }
    }
}
