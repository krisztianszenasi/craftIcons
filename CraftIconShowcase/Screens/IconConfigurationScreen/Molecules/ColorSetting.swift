//
//  ColorSetting.swift
//  CraftIconShowcase
//
//  Created by Krisztián Szénási on 2025. 07. 18..
//

import UIKit

class ColorSetting: UIView {

    private let titleLabel = CraftBodyLabel(textAlignment: .left)
    private var solidColorView: CraftIconView!
    var onColorTap: (() -> Void)? = nil
    
    init(text: String, color: UIColor) {
        super.init(frame: .zero)
        
        titleLabel.text = text
        solidColorView = CraftIconView(config: CraftIconViewConfig(colorConfig: CraftColoredViewConfig(solidColor: color)))
        solidColorView.isUserInteractionEnabled = true

        let tap = UITapGestureRecognizer(target: self, action: #selector(handleColorTap))
        solidColorView.addGestureRecognizer(tap)

        layout()
    }
    
    @objc func handleColorTap() {
        onColorTap?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(color: UIColor) {
        var currentConfig = solidColorView.getConfig()
        currentConfig.colorConfig?.solidColor = color
        solidColorView.updateStyle(with: currentConfig)
    }
    
    private func layout() {
        addSubview(titleLabel)
        addSubview(solidColorView)
        
        solidColorView.layer.cornerRadius = 3
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            solidColorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            solidColorView.topAnchor.constraint(equalTo: topAnchor),
            solidColorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            solidColorView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: UIHelpers.padding)
        ])
    }
}
