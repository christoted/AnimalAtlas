//
//  AnimalListViewModel.swift
//  AnimalAtlas
//
//  Created by Christopher Minarto  on 16/01/24.
//

import Foundation
import RxSwift
import RxCocoa

class AnimalListViewModel {
    
    init() {}
    
    func provideAnimalList() -> [String] {
        return ["Elephant", "Lion", "Fox", "Dog", "Shark", "Turtle", "Whale", "Penguin"]
    }
    
}
