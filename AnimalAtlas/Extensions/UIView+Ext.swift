//
//  UIView+Ext.swift
//  AnimalAtlas
//
//  Created by Christopher Minarto  on 16/01/24.
//

import UIKit

public extension UIView {
    func dropShadow() {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2)
        self.layer.shadowOpacity = 0.25
        self.layer.shadowRadius = 4
    }
}
