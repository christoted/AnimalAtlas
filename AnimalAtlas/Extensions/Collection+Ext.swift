//
//  Collection+Ext.swift
//  AnimalAtlas
//
//  Created by Christopher Minarto  on 17/01/24.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
