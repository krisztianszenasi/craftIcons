//
//  CraftIconViewConfig.swift
//  CraftIconShowcase
//
//  Created by Krisztián Szénási on 2025. 07. 16..
//

import UIKit


enum CraftIconSize: CGFloat {
    case small = 64
    case medium = 96
    case large = 128
    case xlarge = 160
}


struct CraftIconViewConfig {
    var iconSize: CraftIconSize
    var fontConfig: CraftFontConfig = CraftFontConfig()
    var colorConfig: CraftColoredViewConfig? = nil
}
