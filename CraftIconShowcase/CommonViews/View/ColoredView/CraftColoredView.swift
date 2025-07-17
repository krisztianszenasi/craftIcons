//
//  CraftColoredView.swift
//  CraftIconShowcase
//
//  Created by Krisztián Szénási on 2025. 07. 16..
//

import UIKit

class CraftColoredView: UIView {
    
    var config: CraftColoredViewConfig!
    var gradientLayer: CraftGradientColoredView? = nil

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(solid: UIColor) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        self.config = CraftColoredViewConfig(solidColor: solid)
        update(with: config)
    }
    
    init(gradientColors: [UIColor], direction: CraftColorDirection) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        self.config = CraftColoredViewConfig(gradientColors: gradientColors, colorDirection: direction)
        update(with: config)
    }

    func update(with config: CraftColoredViewConfig) {
        reset()
        self.config = config
        switch(config.type){
        case .solid:
            backgroundColor = config.solidColor
        case .gradient:
            let gradient = CraftGradientColoredView(colors: config.gradientColors!, direction: config.colorDirection!)
            gradient.translatesAutoresizingMaskIntoConstraints = false
            addSubview(gradient)

            NSLayoutConstraint.activate([
                gradient.topAnchor.constraint(equalTo: topAnchor),
                gradient.leadingAnchor.constraint(equalTo: leadingAnchor),
                gradient.trailingAnchor.constraint(equalTo: trailingAnchor),
                gradient.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])

            gradientLayer = gradient
        }
    }
    
    private func reset() {
        gradientLayer?.removeFromSuperview()
        gradientLayer = nil
        config = nil
    }
}
