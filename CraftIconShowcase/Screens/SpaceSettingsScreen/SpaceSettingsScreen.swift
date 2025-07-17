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
    private let headerSection = UIView()
    private let bodySection = UIView()
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
        view.addSubview(headerSection)
        headerSection.translatesAutoresizingMaskIntoConstraints = false
        headerSection.backgroundColor = .systemPink
        
        NSLayoutConstraint.activate([
            headerSection.topAnchor.constraint(equalTo: screenTitle.bottomAnchor, constant: UIHelpers.padding),
            headerSection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIHelpers.padding),
            headerSection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIHelpers.padding),
            headerSection.heightAnchor.constraint(equalToConstant: 130)
        ])
        
        iconSectionVC = IconSectionViewController(spaceName: spaceName)
        UIHelpers.add(childViewController: iconSectionVC, to: headerSection, in: self)
        UIHelpers.addSeparator(below: headerSection, in: view)
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
        view.addSubview(bodySection)
        bodySection.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bodySection.topAnchor.constraint(equalTo: headerSection.bottomAnchor, constant: UIHelpers.padding),
            bodySection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIHelpers.padding),
            bodySection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIHelpers.padding),
            bodySection.bottomAnchor.constraint(equalTo: footerSection.topAnchor, constant: -UIHelpers.padding)
        ])
        UIHelpers.addSeparator(below: bodySection, in: view)
        
        let spaceSettingsVC = SpaceSettignsSectionViewController(
            spaceName: spaceName,
            updateSpaceNameCallback: handleSpaceNameUpdate
        )
        UIHelpers.add(childViewController: spaceSettingsVC, to: bodySection, in: self)
    }
    
    private func handleSpaceNameUpdate(_ newName: String) {
        spaceName = newName
        iconSectionVC.updateSpaceName(spaceName: newName)
    }
    
}
