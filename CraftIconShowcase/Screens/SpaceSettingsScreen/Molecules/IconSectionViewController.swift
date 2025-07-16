//
//  IconSectionViewController.swift
//  CraftIconShowcase
//
//  Created by Krisztián Szénási on 2025. 07. 16..
//

import UIKit

class IconSectionViewController: UIViewController {

    private var spaceIcon: CraftIconView!
    private var iconLabel = CraftTitleLabel(textAlignment: .left, fontSize: 20)
    private var tapToChangeLabel = CraftBodyLabel(textAlignment: .left)
    
    
    
    init(spaceName: String) {
        super.init(nibName: nil, bundle: nil)
        configureSpaceIcon(spaceName: spaceName)
        configureLabels()
        setupIconConfigNavigation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func updateSpaceName(spaceName: String) {
        spaceIcon.update(text: spaceName)
    }
    
    private func configureSpaceIcon(spaceName: String) {
        spaceIcon = CraftIconView(
            text: spaceName,
            config: CraftIconViewConfig(
                iconSize: .large,
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
        )
        view.addSubview(spaceIcon)
        
        NSLayoutConstraint.activate([
            spaceIcon.topAnchor.constraint(equalTo: view.topAnchor),
            spaceIcon.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            spaceIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            spaceIcon.widthAnchor.constraint(equalTo: spaceIcon.heightAnchor)
        ])
        
        spaceIcon.update(text: spaceName)
    }
    
    private func configureLabels() {
        iconLabel.text = "Icon"
        tapToChangeLabel.text = "Tap to change icon"
        
        let stack = UIStackView(arrangedSubviews: [iconLabel, tapToChangeLabel])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: spaceIcon.trailingAnchor, constant: UIHelpers.padding),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIHelpers.padding),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
    
    private func setupIconConfigNavigation() {
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(navigateToIconConfig))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapgesture)
    }
    
    @objc func navigateToIconConfig() {
        let iconConfigScreen = IconConfigurationScreen()
        
        if let parentVC = self.parent {
            let navController = UINavigationController(rootViewController: iconConfigScreen)
            parentVC.present(navController, animated: true)
        }
    }
}
