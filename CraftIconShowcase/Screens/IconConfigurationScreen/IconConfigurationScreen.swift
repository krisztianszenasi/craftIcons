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
        let icon = IconConfigSettingsSection()
        UIHelpers.add(childViewController: icon, to: bodySection, in: self)
        NSLayoutConstraint.activate([
            icon.view.widthAnchor.constraint(equalTo: bodySection.widthAnchor)
        ])
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

    
    private func configureFontSetting() {
        view.addSubview(fontSettingSection)
        fontSettingSection.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            fontSettingSection.topAnchor.constraint(equalTo: spaceIcon.bottomAnchor, constant: UIHelpers.padding),
            fontSettingSection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIHelpers.padding),
            fontSettingSection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIHelpers.padding),
        ])
        UIHelpers.addSeparator(below: fontSettingSection, in: view)
        
        let fontPicker = IconFontSettings()
        fontPicker.onFontSelected = { [weak self] fontName in
            self?.spaceIcon.updateFont(fontName: fontName)
        }
        fontSetting = IconSettingViewController(title: "Display Text", isOn: !spaceIcon.getConfig().titleIsHidden, child: fontPicker) { [weak self] _ in
            guard let self = self else { return }
            self.spaceIcon.toggleText()
        }
        UIHelpers.add(childViewController: fontSetting, to: fontSettingSection, in: self)
    }
    
    
    @objc func applyChangesButtonTap() {
        applyChangesCallback(spaceIcon.getConfig())
        dismissVC()
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}
