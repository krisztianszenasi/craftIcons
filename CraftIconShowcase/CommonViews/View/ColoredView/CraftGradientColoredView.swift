//
//  CraftGradientColoredView.swift
//  CraftIconShowcase
//
//  Created by Krisztián Szénási on 2025. 07. 16..
//

import UIKit

class CraftGradientColoredView: UIView {
    private let gradientLayer = CAGradientLayer()

    init(colors: [UIColor], direction: CraftColorDirection) {
        super.init(frame: .zero)
        setup(colors: colors, direction: direction)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(colors: [UIColor], direction: CraftColorDirection) {
        translatesAutoresizingMaskIntoConstraints = false
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = direction.startPoint
        gradientLayer.endPoint = direction.endPoint
        layer.insertSublayer(gradientLayer, at: 0)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}
