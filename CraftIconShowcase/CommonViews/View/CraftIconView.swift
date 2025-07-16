//
//  CraftIconView.swift
//  CraftIconShowcase
//
//  Created by Krisztián Szénási on 2025. 07. 16..
//

import UIKit

enum CraftIconSize: CGFloat {
    case small = 64
    case medium = 96
    case large = 128
    case xlarge = 160
}





class CraftIconView: UIView {

    let titleLabel: CraftTitleLabel!
    
    init(text: String, iconSize: CraftIconSize) {
        titleLabel = CraftTitleLabel(textAlignment: .center, fontSize: iconSize.rawValue / 3)
        super.init(frame: .zero)
        configureView(iconSize: iconSize.rawValue)
        configureTitleLabel(text: text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
