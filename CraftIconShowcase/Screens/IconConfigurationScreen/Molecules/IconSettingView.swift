//
//  IconSettingView.swift
//  CraftIconShowcase
//
//  Created by Krisztián Szénási on 2025. 07. 17..
//

import UIKit

class IconSettingView: UIView {

    private var onToggleSetting: () -> Void
    
    private let titleLabel = CraftTitleLabel(textAlignment: .left, fontSize: 16)
    private let switchButton = UISwitch()
    
    init(title: String, isOn: Bool, onToggleSetting: @escaping () -> Void) {
        self.onToggleSetting = onToggleSetting
        super.init(frame: .zero)
        titleLabel.text = title
        switchButton.isOn = isOn
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        configureTitleLabel()
        configureSwitchButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.textColor = .label
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            titleLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    private func configureSwitchButton() {
        addSubview(switchButton)
        switchButton.translatesAutoresizingMaskIntoConstraints = false
        switchButton.isUserInteractionEnabled = true
        
        switchButton.addTarget(self, action: #selector(handleToggle), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            switchButton.topAnchor.constraint(equalTo: topAnchor),
            switchButton.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    @objc private func handleToggle() {
        onToggleSetting()
    }
            
}
