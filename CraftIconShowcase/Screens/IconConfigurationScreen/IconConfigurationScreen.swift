//
//  IconConfigurationScreen.swift
//  CraftIconShowcase
//
//  Created by Krisztián Szénási on 2025. 07. 17..
//

import UIKit

class IconConfigurationScreen: UIViewController {
    
    private var applyChangesCallback: (CraftIconViewConfig) -> Void
    
    private let headerSection = UIView()
    private let bodySection = UIScrollView()
    private let footerSection = UIView()
    
    private let spaceIcon: CraftIconView!
    
    private var fontSettingSection = UIView()
    private var solidColorSection = UIView()
    private var gradientColorSection = UIView()
    private var applyChangesButton = CraftButton(backgroundColor: .systemBlue, title: "Apply changes")
    
    
    private var fontSetting: IconSettingViewController!
    private var colorSettings: IconSettingViewController!
    private var imageSetttings: IconSettingViewController!

    init(spaceName: String, iconConfig: CraftIconViewConfig, applyChangesCallback: @escaping (CraftIconViewConfig) -> Void) {
        spaceIcon = CraftIconView(text: spaceName, config: iconConfig)
        self.applyChangesCallback = applyChangesCallback
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layout()
        configureSpaceIcon()
        configureSettingsSection()
        configureApplyChangesButton()
    }
    
    func configureViewController() {
        title = "Icon Configuration"
        view.backgroundColor = .systemBackground
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = cancelButton
    }
    
    private func configureSpaceIcon() {
        headerSection.addSubview(spaceIcon)
        NSLayoutConstraint.activate([
            spaceIcon.topAnchor.constraint(equalTo: headerSection.topAnchor),
            spaceIcon.widthAnchor.constraint(equalTo: headerSection.heightAnchor),
            spaceIcon.heightAnchor.constraint(equalTo: spaceIcon.widthAnchor),
            spaceIcon.centerXAnchor.constraint(equalTo: headerSection.centerXAnchor)
        ])
    }
    
    private func configureSettingsSection() {
        // 1. Create content view inside scroll view
        let scrollContentView = UIView()
        scrollContentView.translatesAutoresizingMaskIntoConstraints = false
        bodySection.addSubview(scrollContentView)

        // 2. Pin content view to scroll view
        NSLayoutConstraint.activate([
            scrollContentView.topAnchor.constraint(equalTo: bodySection.topAnchor),
            scrollContentView.leadingAnchor.constraint(equalTo: bodySection.leadingAnchor),
            scrollContentView.trailingAnchor.constraint(equalTo: bodySection.trailingAnchor),
            scrollContentView.bottomAnchor.constraint(equalTo: bodySection.bottomAnchor),
            scrollContentView.widthAnchor.constraint(equalTo: bodySection.widthAnchor) // important for vertical scrolling
        ])

        // 3. Create and embed child view controller
        let iconSettingsVC = IconConfigSettingsSection(iconConfig: spaceIcon.getConfig()) { [weak self] config in
            self?.spaceIcon.updateStyle(with: config)
        }

        addChild(iconSettingsVC)
        scrollContentView.addSubview(iconSettingsVC.view)
        iconSettingsVC.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            iconSettingsVC.view.topAnchor.constraint(equalTo: scrollContentView.topAnchor),
            iconSettingsVC.view.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor),
            iconSettingsVC.view.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -4),
            iconSettingsVC.view.bottomAnchor.constraint(equalTo: scrollContentView.bottomAnchor),
            
            // 💡 This line ensures the scroll view has a defined content height
            iconSettingsVC.view.heightAnchor.constraint(greaterThanOrEqualToConstant: 500) // try an appropriate value here
        ])

        iconSettingsVC.didMove(toParent: self)
    }
    
    private func configureApplyChangesButton() {
        footerSection.addSubview(applyChangesButton)
        
        applyChangesButton.addTarget(self, action: #selector(applyChangesButtonTap), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            applyChangesButton.bottomAnchor.constraint(equalTo: footerSection.bottomAnchor),
            applyChangesButton.leadingAnchor.constraint(equalTo: footerSection.leadingAnchor),
            applyChangesButton.trailingAnchor.constraint(equalTo: footerSection.trailingAnchor),
            applyChangesButton.topAnchor.constraint(equalTo: footerSection.topAnchor)
        ])
    }
    
    
    private func layout() {
        headerSection.translatesAutoresizingMaskIntoConstraints = false
        bodySection.translatesAutoresizingMaskIntoConstraints = false
        footerSection.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(headerSection)
        view.addSubview(bodySection)
        view.addSubview(footerSection)
        
        UIHelpers.addSeparator(above: headerSection, in: view)
        UIHelpers.addSeparator(below: headerSection, in: view)
        UIHelpers.addSeparator(below: bodySection, in: view)
        
        NSLayoutConstraint.activate([
            headerSection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: UIHelpers.padding),
            headerSection.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2),
            headerSection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIHelpers.padding),
            headerSection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIHelpers.padding),
            
            footerSection.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier:  1/8),
            footerSection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIHelpers.padding),
            footerSection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIHelpers.padding),
            footerSection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -UIHelpers.padding),
            
            bodySection.topAnchor.constraint(equalTo: headerSection.bottomAnchor, constant: UIHelpers.padding),
            bodySection.bottomAnchor.constraint(equalTo: footerSection.topAnchor, constant: -UIHelpers.padding),
            bodySection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIHelpers.padding),
            bodySection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIHelpers.padding)
        ])
    }

    @objc func applyChangesButtonTap() {
        applyChangesCallback(spaceIcon.getConfig())
        dismissVC()
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}
