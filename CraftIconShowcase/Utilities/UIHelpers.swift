//
//  UIHelpers.swift
//  CraftIconShowcase
//
//  Created by Krisztián Szénási on 2025. 07. 16..
//

import UIKit


struct UIHelpers {
    
    static func addSeparator(below viewAbove: UIView, in container: UIView, padding: CGFloat = 20) {
        let separator = CraftSeparatorView()
        container.addSubview(separator)
                
        NSLayoutConstraint.activate([
            separator.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: padding),
            separator.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -padding),
            separator.topAnchor.constraint(equalTo: viewAbove.bottomAnchor, constant: padding / 2)
        ])
    }
}
