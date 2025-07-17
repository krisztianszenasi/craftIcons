//
//  IconConfigurationScreen.swift
//  CraftIconShowcase
//
//  Created by Krisztián Szénási on 2025. 07. 17..
//

import UIKit

class IconConfigurationScreen: UIViewController {
    
    private var applyChangesCallback: (CraftIconViewConfig) -> Void
    
    private let spaceIcon: CraftIconView!
    
    private var fontSettingSection = UIView()
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
        configureSpaceIcon()
        configureFontSetting()
        configureColorSettings()
        configureImageSettings()
        configureApplyChangesButton()
    }
    
    func configureViewController() {
        title = "Icon Configuration"
        view.backgroundColor = .systemBackground
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = cancelButton
    }
    
    private func configureSpaceIcon() {
        view.addSubview(spaceIcon)
        NSLayoutConstraint.activate([
            spaceIcon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: UIHelpers.padding),
            spaceIcon.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2),
            spaceIcon.heightAnchor.constraint(equalTo: spaceIcon.widthAnchor),
            spaceIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        UIHelpers.addSeparator(above: spaceIcon, in: view)
        UIHelpers.addSeparator(below: spaceIcon, in: view)
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
    
    private func configureColorSettings() {
//        let view1 = UIView()
//        view.backgroundColor = .systemRed
//        let view2 = UIView()
//        view.backgroundColor = .systemGreen
//        
//        let switcher = CraftSegmentedSwitcherViewController(tabs: [
//            ("read", view1),
//            ("green", view2)
//        ])
//        
//        colorSettings = IconSettingView(title: "Use colored background", isOn: true, childView: nil, onToggleSetting: {
//            // hello
//        })
//        view.addSubview(colorSettings)
//        NSLayoutConstraint.activate([
//            colorSettings.topAnchor.constraint(equalTo: fontSetting.bottomAnchor, constant: UIHelpers.padding),
//            colorSettings.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIHelpers.padding),
//            colorSettings.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIHelpers.padding),
//            colorSettings.heightAnchor.constraint(equalToConstant: 25)
//        ])
//        UIHelpers.addSeparator(below: colorSettings, in: view)
    }
    
    private func configureImageSettings() {
//        imageSetttings = IconSettingView(title: "Use image as background", isOn: false, onToggleSetting: {
//            // hello
//        })
//        view.addSubview(imageSetttings)
//        NSLayoutConstraint.activate([
//            imageSetttings.topAnchor.constraint(equalTo: colorSettings.bottomAnchor, constant: UIHelpers.padding),
//            imageSetttings.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIHelpers.padding),
//            imageSetttings.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIHelpers.padding),
//            imageSetttings.heightAnchor.constraint(equalToConstant: 25)
//        ])
    }
    
    private func configureApplyChangesButton() {
        view.addSubview(applyChangesButton)
        
        applyChangesButton.addTarget(self, action: #selector(applyChangesButtonTap), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            applyChangesButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            applyChangesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIHelpers.padding),
            applyChangesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIHelpers.padding),
            applyChangesButton.heightAnchor.constraint(equalToConstant: 50)
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
