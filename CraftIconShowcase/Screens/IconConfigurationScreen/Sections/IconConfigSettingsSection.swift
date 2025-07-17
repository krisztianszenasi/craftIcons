//
//  IconConfigSettingsSection.swift
//  CraftIconShowcase
//
//  Created by Krisztián Szénási on 2025. 07. 17..
//

import UIKit

class IconConfigSettingsSection: UIViewController {
    
    private var iconConfig: CraftIconViewConfig!
    private var updateIconStyleCallback: (CraftIconViewConfig) -> Void
    
    private var fontSection = UIView()
    
    
    init(iconConfig: CraftIconViewConfig, updateIconStyleCallback: @escaping (CraftIconViewConfig) -> Void) {
        self.iconConfig = iconConfig
        self.updateIconStyleCallback = updateIconStyleCallback
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.translatesAutoresizingMaskIntoConstraints = false
        configureFontSetting()
    }
    
    private func configureFontSetting() {
        view.addSubview(fontSection)
        fontSection.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            fontSection.topAnchor.constraint(equalTo: view.topAnchor),
            fontSection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            fontSection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        UIHelpers.addSeparator(below: fontSection, in: view, horizontalPadding: 0)
        
        let fontPicker = IconFontSettings()
        fontPicker.onFontSelected = { [weak self] fontName in
            guard let self = self else { return }
            iconConfig.fontConfig.name = fontName
            updateIconStyleCallback(iconConfig)
        }
        let fontSetting = IconSettingViewController(title: "Display Text", isOn: !iconConfig.titleIsHidden, child: fontPicker) { [weak self] _ in
            guard let self = self else { return }
            iconConfig.titleIsHidden.toggle()
            updateIconStyleCallback(iconConfig)
        }
        UIHelpers.add(childViewController: fontSetting, to: fontSection, in: self)
    }
}
