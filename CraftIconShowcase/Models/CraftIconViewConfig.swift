//
//  CraftIconViewConfig.swift
//  CraftIconShowcase
//
//  Created by Krisztián Szénási on 2025. 07. 16..
//

import UIKit

struct CraftIconViewConfig {
    var fontConfig: CraftFontConfig
    var colorConfig: CraftColoredViewConfig? = nil
    
    init() {
        fontConfig = CraftFontConfig()
        colorConfig = CraftColoredViewConfig()
    }
}
