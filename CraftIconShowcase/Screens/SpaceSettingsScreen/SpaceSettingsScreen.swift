//
//  SpaceSettingsScreen.swift
//  CraftIconShowcase
//
//  Created by Krisztián Szénási on 2025. 07. 16..
//

import UIKit

class SpaceSettingsScreen: UIViewController {
    
    private var spaceName: String = "Talent Acquisition"
    
    private let titleLabel = CraftTitleLabel(textAlignment: .left, fontSize: 34)
    private let headerSection = UIView()
    private let bodySection = UIView()
    private let footerSection = UIView()
    
    private var iconSectionVC: IconSectionViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layout()
        includeSeparators()
        fillSections()
    }
    
    private func layout() {
        titleLabel.text = "Space Settings"
        
        view.addSubview(titleLabel)
        view.addSubview(headerSection)
        view.addSubview(footerSection)
        view.addSubview(bodySection)
    
        headerSection.translatesAutoresizingMaskIntoConstraints = false
        footerSection.translatesAutoresizingMaskIntoConstraints = false
        bodySection.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: UIHelpers.padding),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIHelpers.padding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIHelpers.padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 38),
            
            headerSection.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: UIHelpers.padding),
            headerSection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIHelpers.padding),
            headerSection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIHelpers.padding),
            headerSection.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3),
            
            footerSection.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -UIHelpers.padding),
            footerSection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIHelpers.padding),
            footerSection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIHelpers.padding),
            footerSection.heightAnchor.constraint(equalToConstant: 50),
            
            bodySection.topAnchor.constraint(equalTo: headerSection.bottomAnchor, constant: UIHelpers.padding),
            bodySection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIHelpers.padding),
            bodySection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIHelpers.padding),
            bodySection.bottomAnchor.constraint(equalTo: footerSection.topAnchor, constant: -UIHelpers.padding)
        ])
    }
    
    private func includeSeparators() {
        let shouldHaveSeparatorsBelow = [titleLabel, headerSection, bodySection]
        for viewAbove in shouldHaveSeparatorsBelow {
            UIHelpers.addSeparator(below: viewAbove, in: view)
        }
    }
    
    private func fillSections() {
        iconSectionVC = IconSectionViewController(spaceName: spaceName)
        UIHelpers.add(childViewController: iconSectionVC, to: headerSection, in: self)
        UIHelpers.add(
            childViewController: SpaceSettignsSectionViewController(
                spaceName: spaceName,
                updateSpaceNameCallback: handleSpaceNameUpdate
            ),
            to: bodySection,
            in: self
        )
        
        let footerLabel = CraftBodyLabel(textAlignment: .center)
        footerLabel.text = "made by krisztianszenasi"
        footerSection.addSubview(footerLabel)
        
        NSLayoutConstraint.activate([
            footerLabel.centerXAnchor.constraint(equalTo: footerSection.centerXAnchor),
            footerLabel.centerYAnchor.constraint(equalTo: footerSection.centerYAnchor)
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
