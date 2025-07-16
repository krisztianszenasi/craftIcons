//
//  CraftSeparatorView.swift
//  CraftIconShowcase
//
//  Created by Krisztián Szénási on 2025. 07. 16..
//

import UIKit

class CraftSeparatorView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        backgroundColor = .lightGray
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale)
        ])
    }
}
