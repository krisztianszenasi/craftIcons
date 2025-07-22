//
//  CraftSwitch.swift
//  CraftIconShowcase
//
//  Created by Krisztián Szénási on 2025. 07. 21..
//

import UIKit

class CraftSwitch: UISwitch {
    
    init() {
        super.init(frame: .zero)
        onTintColor = .systemLightBlue
        thumbTintColor = .invertedLabel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
