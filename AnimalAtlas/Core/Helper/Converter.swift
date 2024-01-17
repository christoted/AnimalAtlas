//
//  Converter.swift
//  AnimalAtlas
//
//  Created by Christopher Minarto  on 17/01/24.
//

import Foundation

class Converter {
    static let shared = Converter()
    
    func convertArrayToString(arrayOfString: [String]) -> String {
        var stringResults = ""
        for (index, value) in arrayOfString.enumerated() {
            if index != arrayOfString.count - 1 {
                stringResults += value + ", "
            } else {
                stringResults += value
            }
        }
        return stringResults
    }
}
