//
//  NSObject+Ext.swift
//  AnimalAtlas
//
//  Created by Christopher Minarto  on 16/01/24.
//

import Foundation

public extension NSObject {
    
    func className() -> String {
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last ?? ""
    }
    
    static func className() -> String {
        return NSStringFromClass(self).components(separatedBy: ".").last ?? ""
    }
    
}
