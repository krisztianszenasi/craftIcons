//
//  ViewController.swift
//  CraftIconShowcase
//
//  Created by Krisztián Szénási on 2025. 07. 16..
//

import UIKit

class ViewController: UIViewController {
    
    let titleLabel = CraftTitleLabel(textAlignment: .left, fontSize: 34)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        titleLabel.text = "Space Settings"
        
        let stack = UIStackView(arrangedSubviews: [
            CraftIconView(
                text: "Team Acqusition",
                config: CraftIconViewConfig(
                    iconSize: .xlarge,
                    fontConfig: CraftFontConfig(
                        name: "AvenirNext-Bold",
                        size: 30,
                        color: .white
                    ),
                    colorConfig: CraftColoredViewConfig(
                        type: .gradient,
                        gradientColors: [.systemRed, .systemBlue],
                        colorDirection: .topLeftToBottomRight
                    )
                )
            ),
        ])
        
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 38),
            
            stack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
        ])
        
        UIHelpers.addSeparator(below: titleLabel, in: view)
    }
}

