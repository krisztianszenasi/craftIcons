//
//  CraftIconView.swift
//  CraftIconShowcase
//
//  Created by Krisztián Szénási on 2025. 07. 16..
//

import UIKit


class CraftIconView: UIView {

    private var config: CraftIconViewConfig!
    
    private let titleLabel = CraftDynamicFontLabel()
    private let coloredView = CraftColoredView(gradientColors: [.systemRed, .systemBlue], direction: .topLeftToBottomRight)
    
    init(text: String, config: CraftIconViewConfig) {
        super.init(frame: .zero)
        self.config = config
        
        configureView()
        configureColoredView()
        configureTitleLabel(text: text)
        
        updateStyle(with: config)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(text: String) {
        titleLabel.text = StringUtils.getInitials(for: text)
    }
    
    func updateStyle(with config: CraftIconViewConfig) {
        reset()
        
        titleLabel.update(with: config.fontConfig)

        if let colorConfig = config.colorConfig {
            coloredView.update(with: colorConfig)
            coloredView.isHidden = false
        } else {
            print("no config")
        }
        
        self.config = config
    }
    
    func getConfig() -> CraftIconViewConfig {
        return config
    }
    
    private func reset() {
        coloredView.isHidden = true
    }
        
    private func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 30
        clipsToBounds = true
    }
    
    private func configureColoredView() {
        addSubview(coloredView)
        sendSubviewToBack(coloredView)
        coloredView.isHidden = true
        
        NSLayoutConstraint.activate([
            coloredView.topAnchor.constraint(equalTo: topAnchor),
            coloredView.leadingAnchor.constraint(equalTo: leadingAnchor),
            coloredView.trailingAnchor.constraint(equalTo: trailingAnchor),
            coloredView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
    private func configureTitleLabel(text: String) {
        addSubview(titleLabel)
        titleLabel.text = StringUtils.getInitials(for: text)
        titleLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            titleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8)
        ])
    }
}
