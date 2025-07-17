//
//  CraftIconViewConfig.swift
//  CraftIconShowcase
//
//  Created by Krisztián Szénási on 2025. 07. 16..
//

import UIKit

struct CraftIconViewConfig {
    var titleIsHidden = false
    var fontConfig: CraftFontConfig
    var colorConfig: CraftColoredViewConfig? = nil
    
    
    init(titleIsHidden: Bool = false, fontConfig: CraftFontConfig = CraftFontConfig(), colorConfig: CraftColoredViewConfig = CraftColoredViewConfig()) {
        self.titleIsHidden = titleIsHidden
        self.fontConfig = fontConfig
        self.colorConfig = colorConfig
    }
}
