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
        return [Constant.elephant, Constant.lion, Constant.fox, Constant.dog, Constant.shark, Constant.turtle, Constant.whale, Constant.penguin]
    }
    
}
