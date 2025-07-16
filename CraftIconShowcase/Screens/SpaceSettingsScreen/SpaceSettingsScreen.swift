//
//  SpaceSettingsScreen.swift
//  CraftIconShowcase
//
//  Created by Krisztián Szénási on 2025. 07. 16..
//

import UIKit

class SpaceSettingsScreen: UIViewController {
    
    private var spaceName: String = "Team Acqusition"
    
    private let screenTitle = CraftTitleLabel(textAlignment: .left, fontSize: 34)
    private let iconSection = UIView()
    private let spaceSettingsSection = UIView()
    private let footerSection = UIView()
    
    private var iconSectionVC: IconSectionViewController!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureScreenTitle()
        configureIconSection()
        configureFooterSection()
        configureSpaceSettingsSection()
    }
    
    
    private func configureScreenTitle() {
        view.addSubview(screenTitle)
        screenTitle.text = "Space Settings"
        NSLayoutConstraint.activate([
            screenTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: UIHelpers.padding),
            screenTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIHelpers.padding),
            screenTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIHelpers.padding),
            screenTitle.heightAnchor.constraint(equalToConstant: 38)
        ])
        UIHelpers.addSeparator(below: screenTitle, in: view)
    }
    
    private func configureIconSection() {
        view.addSubview(iconSection)
        iconSection.translatesAutoresizingMaskIntoConstraints = false
        iconSection.backgroundColor = .systemPink
        
        NSLayoutConstraint.activate([
            iconSection.topAnchor.constraint(equalTo: screenTitle.bottomAnchor, constant: UIHelpers.padding),
            iconSection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIHelpers.padding),
            iconSection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIHelpers.padding),
            iconSection.heightAnchor.constraint(equalToConstant: 130)
        ])
        
        iconSectionVC = IconSectionViewController(spaceName: spaceName)
        add(childViewController: iconSectionVC, to: iconSection)
        UIHelpers.addSeparator(below: iconSection, in: view)
    }
    
    private func configureFooterSection() {
        view.addSubview(footerSection)
        footerSection.translatesAutoresizingMaskIntoConstraints = false
        footerSection.backgroundColor = .systemPink
        
        NSLayoutConstraint.activate([
            footerSection.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -UIHelpers.padding),
            footerSection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIHelpers.padding),
            footerSection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIHelpers.padding),
            footerSection.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureSpaceSettingsSection() {
        view.addSubview(spaceSettingsSection)
        spaceSettingsSection.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            spaceSettingsSection.topAnchor.constraint(equalTo: iconSection.bottomAnchor, constant: UIHelpers.padding),
            spaceSettingsSection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIHelpers.padding),
            spaceSettingsSection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIHelpers.padding),
            spaceSettingsSection.bottomAnchor.constraint(equalTo: footerSection.topAnchor, constant: -UIHelpers.padding)
        ])
        UIHelpers.addSeparator(below: iconSection, in: view)
        
        add(
            childViewController: SpaceSettignsSectionViewController(spaceName: spaceName, updateSpaceName: {  [weak self]  spaceName in
                guard let self = self else { return }
                self.iconSectionVC.updateSpaceName(spaceName: spaceName)
            }),
            to: spaceSettingsSection
        )
    }

    
    func add(childViewController: UIViewController, to containerView: UIView) {
        addChild(childViewController)
        containerView.addSubview(childViewController.view)
        
        let childView = childViewController.view!
        childView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            childView.topAnchor.constraint(equalTo: containerView.topAnchor),
            childView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            childView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            childView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
        
        childViewController.didMove(toParent: self)
    }
}
