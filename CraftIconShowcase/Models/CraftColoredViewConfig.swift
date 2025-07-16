//
//  CraftColoredViewConfig.swift
//  CraftIconShowcase
//
//  Created by Krisztián Szénási on 2025. 07. 16..
//

import UIKit

enum CraftColorType {
    case solid
    case gradient
}

struct CraftColoredViewConfig {
    var type: CraftColorType
    
    var solidColor: UIColor? = nil
    
    var gradientColors: [UIColor]? = nil
    var colorDirection: CraftColorDirection? = nil
}
