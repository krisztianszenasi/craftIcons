//
//  CraftIconView.swift
//  CraftIconShowcase
//
//  Created by Krisztián Szénási on 2025. 07. 16..
//

import UIKit


class CraftIconView: UIView {

    private let titleLabel = CraftDynamicFontLabel()
    private var config: CraftIconViewConfig!

    
    init(text: String, config: CraftIconViewConfig) {
        super.init(frame: .zero)
        self.config = config
        configureView(iconSize: config.iconSize.rawValue)
        configureTitleLabel(text: text)
        updateStyle(with: config)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func updateStyle(with config: CraftIconViewConfig) {
        titleLabel.update(with: config.fontConfig)
        self.config = config
    }
    
    func getConfig() -> CraftIconViewConfig {
        return config
    }
    
    private func configureView(iconSize: CGFloat) {
        backgroundColor = .systemPink
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = iconSize / 5
        clipsToBounds = true
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: iconSize),
            heightAnchor.constraint(equalToConstant: iconSize)
        ])
    }
    
    private func configureTitleLabel(text: String) {
        addSubview(titleLabel)
        titleLabel.text = StringUtils.getInitials(for: text)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    
}
