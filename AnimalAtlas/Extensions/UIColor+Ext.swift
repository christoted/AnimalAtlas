//
//  UIColor+Ext.swift
//  AnimalAtlas
//
//  Created by Christopher Minarto  on 16/01/24.
//

import UIKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

public enum AnimalAtlasColor {
    case textPrimary
    case textSecondy
    case blue
    
    public var color: UIColor {
        switch self {
        case .textPrimary:
            return UIColor(hex: "#1A2258")
        case .textSecondy:
            return UIColor(hex: "#787D9C")
        case .blue:
            return UIColor(hex: "#216BFF")
        }
    }
}
