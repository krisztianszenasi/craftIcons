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
    private var solidColorSection = UIView()
    private var gradientColorSection = UIView()
    
    private var solidColorSetting: ColorSetting!
    private var gradientColorSetting: GradientColorSetting!
    
    
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
        configureSolidColorSetting()
        configureGradientColorSetting()
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
    
    private func configureSolidColorSetting() {
        view.addSubview(solidColorSection)
        solidColorSection.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            solidColorSection.topAnchor.constraint(equalTo: fontSection.bottomAnchor, constant: UIHelpers.padding),
            solidColorSection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            solidColorSection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        UIHelpers.addSeparator(below: solidColorSection, in: view, horizontalPadding: 0)
        
        solidColorSetting = ColorSetting(text: "Selected Color", color: iconConfig.colorConfig?.solidColor ?? .systemPink)
        solidColorSetting.onColorTap = {
            let colorPickerVC = UIColorPickerViewController()
            colorPickerVC.title = "Select Solid Background"
            colorPickerVC.delegate = self
            self.present(colorPickerVC, animated: true)
        }
        
        UIHelpers.add(
            childViewController: IconSettingViewController(
                title: "Use Solid Color As Background",
                isOn: iconConfig.colorConfig?.type == .solid,
                child: solidColorSetting,
                onToggle: { isOn in
                    self.iconConfig.colorConfig?.type = isOn ? .solid : .gradient
                    self.updateIconStyleCallback(self.iconConfig)
                }
            ),
            to: solidColorSection,
            in: self
        )
    }
    
    private func configureGradientColorSetting() {
        view.addSubview(gradientColorSection)
        gradientColorSection.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gradientColorSection.topAnchor.constraint(equalTo: solidColorSection.bottomAnchor, constant: UIHelpers.padding),
            gradientColorSection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientColorSection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        UIHelpers.addSeparator(below: gradientColorSection, in: view, horizontalPadding: 0)
        
        gradientColorSetting = GradientColorSetting(
            firstColor: iconConfig.colorConfig?.gradientColors?[0] ?? .systemRed,
            secondColor: iconConfig.colorConfig?.gradientColors?[1] ?? .systemBlue
        )
        
        gradientColorSetting.onFirstColorTap = {
            print("first")
            let colorPickerVC = UIColorPickerViewController()
            colorPickerVC.title = "Select First Gradient Color"
            colorPickerVC.delegate = self
            self.present(colorPickerVC, animated: true)
        }
        
        gradientColorSetting.onSecondColorTap = {
            print("second")
            let colorPickerVC = UIColorPickerViewController()
            colorPickerVC.title = "Select Second Gradient Color"
            colorPickerVC.delegate = self
            self.present(colorPickerVC, animated: true)
        }
        
        UIHelpers.add(
            childViewController: IconSettingViewController(
                title: "Use Gradient Color As Background",
                isOn: iconConfig.colorConfig?.type == .gradient,
                child: gradientColorSetting,
                onToggle: { isOn in
                    self.iconConfig.colorConfig?.type = isOn ? .gradient : .solid
                    self.updateIconStyleCallback(self.iconConfig)
                }
            ),
            to: gradientColorSection,
            in: self
        )
    }
}


extension IconConfigSettingsSection: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        switch(viewController.title) {
        case "Select Solid Background":
            iconConfig.colorConfig?.solidColor = viewController.selectedColor
            solidColorSetting.update(color: viewController.selectedColor)
        case "Select First Gradient Color":
            iconConfig.colorConfig?.gradientColors?[0] = viewController.selectedColor
            gradientColorSetting.updateFirstColor(color: viewController.selectedColor)
        case "Select Second Gradient Color":
            iconConfig.colorConfig?.gradientColors?[1] = viewController.selectedColor
            gradientColorSetting.updateSecondColor(color: viewController.selectedColor)
        default:
            iconConfig.colorConfig?.solidColor = viewController.selectedColor
        }
        updateIconStyleCallback(iconConfig)
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        self.colorPickerViewControllerDidFinish(viewController)
    }
}
