//
//  UIFont+Ext.swift
//  AnimalAtlas
//
//  Created by Christopher Minarto  on 16/01/24.
//

import UIKit

public extension UIFont {
    static var heading1: UIFont {
        return UIFont.systemFont(ofSize: 22, weight: .semibold)
    }
    
    static var heading: UIFont {
        return UIFont.systemFont(ofSize: 18, weight: .semibold)
    }
    static var heading2: UIFont {
        return UIFont.systemFont(ofSize: 16, weight: .semibold)
    }
    static var body1SemiBold: UIFont {
        return UIFont.systemFont(ofSize: 14, weight: .semibold)
    }
    static var body1: UIFont {
        return UIFont.systemFont(ofSize: 14, weight: .light)
    }
    static var body2: UIFont {
        return UIFont.systemFont(ofSize: 16, weight: .light)
    }
    
}
