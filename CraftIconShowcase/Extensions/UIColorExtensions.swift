//
//  UIColorExtensions.swift
//  CraftIconShowcase
//
//  Created by Krisztián Szénási on 2025. 07. 21..
//

import UIKit

extension UIColor {
    static var invertedLabel: UIColor {
        return UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? .black : .white
        }
    }
    
    static var systemLightBlue: UIColor {
        return UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ?
                UIColor(red: 144/255, green: 213/255, blue: 255/255, alpha: 1)
            :   UIColor(red: 87/255, green: 185/255, blue: 255/255, alpha: 1)
        }
    }
}
