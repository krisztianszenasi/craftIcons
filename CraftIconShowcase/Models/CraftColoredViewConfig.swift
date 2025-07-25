//
//  CraftColoredViewConfig.swift
//  CraftIconShowcase
//
//  Created by Krisztián Szénási on 2025. 07. 16..
//

import UIKit

enum CraftColorType {
    case none
    case solid
    case gradient
    case image
}

struct CraftColoredViewConfig {
    var type: CraftColorType
    
    var solidColor: UIColor? = nil
    var gradientColors: [UIColor]? = nil
    var colorDirection: CraftColorDirection? = nil
    var image: UIImage? = nil
    
    init() {
        self.type = .gradient
        self.solidColor = .systemRed
        self.gradientColors = [.systemRed, .systemBlue]
        self.colorDirection = .topLeftToBottomRight
    }
    
    init(solidColor: UIColor) {
        self.type = .solid
        self.solidColor = solidColor
    }
    
    init(gradientColors: [UIColor], colorDirection: CraftColorDirection) {
        self.type = .gradient
        self.gradientColors = gradientColors
        self.colorDirection = colorDirection
    }
    
    init(image: UIImage) {
        self.type = .image
        self.image = image
    }
}
