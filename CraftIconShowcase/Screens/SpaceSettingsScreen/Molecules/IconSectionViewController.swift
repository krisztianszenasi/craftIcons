//
//  IconSectionViewController.swift
//  CraftIconShowcase
//
//  Created by Krisztián Szénási on 2025. 07. 16..
//

import UIKit

class IconSectionViewController: UIViewController {
    
    private var spaceName: String!

    private var spaceIcon: CraftIconView!
    private var iconLabel = CraftTitleLabel(textAlignment: .left, fontSize: 20)
    private var tapToChangeLabel = CraftBodyLabel(textAlignment: .left)
    
    
    
    init(spaceName: String) {
        self.spaceName = spaceName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        configureSpaceIcon(spaceName: spaceName)
        configureLabels()
        setupIconConfigNavigation()
    }
    
    public func updateSpaceName(spaceName: String) {
        self.spaceName = spaceName
        spaceIcon.update(text: spaceName)
    }
    
    private func configureSpaceIcon(spaceName: String) {
        spaceIcon = CraftIconView(text: spaceName)
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
        let iconConfigScreen = IconConfigurationScreen(spaceName: spaceName, iconConfig: spaceIcon.getConfig()) { [weak self] updatedConfig in
            guard let self = self else { return }
            self.spaceIcon.updateStyle(with: updatedConfig)
        }
        
        if let parentVC = self.parent {
            let navController = UINavigationController(rootViewController: iconConfigScreen)
            parentVC.present(navController, animated: true)
        }
    }
}
