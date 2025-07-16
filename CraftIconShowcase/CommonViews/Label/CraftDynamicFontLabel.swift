//
//  CraftDynamicFontLabel.swift
//  CraftIconShowcase
//
//  Created by Krisztián Szénási on 2025. 07. 16..
//

import UIKit

class CraftDynamicFontLabel: UILabel {
    
    var config: CraftFontConfig!
    
    init(text: String = "", alignment: NSTextAlignment = .center, config: CraftFontConfig = CraftFontConfig()) {
        super.init(frame: .zero)
        self.config = config
        self.translatesAutoresizingMaskIntoConstraints = false
        configure(text: text, alignment: alignment, config: config)
     }

     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    
    func getConfig() -> CraftFontConfig {
        return config
    }

    func configure(text: String, alignment: NSTextAlignment, config: CraftFontConfig) {
        self.text = text
        self.textAlignment = alignment
        
        self.numberOfLines = 1
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.1

        update(with: config)
     }
    
    func update(with config: CraftFontConfig = CraftFontConfig()) {
        updateFontName(config.name)
        updateColor(config.color)
        updateFontSize(config.size)
        self.config = config
    }

     func updateFontSize(_ size: CGFloat?) {
         self.font = self.font.withSize(size ?? 16)
     }

    func updateFontName(_ name: String?) {
        if let name = name, let customFont = UIFont(name: name, size: font.pointSize) {
            self.font = customFont
        } else {
            self.font = UIFont.systemFont(ofSize: font.pointSize)
        }
    }

     func updateColor(_ color: UIColor?) {
         self.textColor = color ?? .label
     }

}
