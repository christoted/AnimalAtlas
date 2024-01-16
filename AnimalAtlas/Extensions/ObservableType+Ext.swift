//
//  ObservableType+Ext.swift
//  AnimalAtlas
//
//  Created by Christopher Minarto  on 17/01/24.
//

import Foundation
import RxCocoa
import RxSwift

extension ObservableType {
    public func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { _ in
            Driver.empty()
        }
    }
}
