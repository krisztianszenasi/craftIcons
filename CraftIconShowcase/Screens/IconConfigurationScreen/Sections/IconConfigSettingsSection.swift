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
    private var imageSection = UIView()
    
    
    private var solidColorIconSettingVC: IconSettingViewController!
    private var solidColorSetting: ColorSetting!
    
    private var gradientColorSettingVC: IconSettingViewController!
    private var gradientColorSetting: GradientColorSetting!
    
    
    private var imageSettingVC: IconSettingViewController!
    private var imageSetting: ImageSettings!
    
    
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
        configureImageSetting()
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
        solidColorSetting.onColorTap = getOnColorTapLogic(for: IconConfigurationStrings.solidColorPickerTitle.rawValue)
        solidColorIconSettingVC = IconSettingViewController(
            title: IconConfigurationStrings.solidColorSettingTitle.rawValue,
            isOn: iconConfig.colorConfig?.type == .solid,
            child: solidColorSetting,
            onToggle: getOnToggleLogic(for: .solid)
        )
        
        UIHelpers.add(
            childViewController: solidColorIconSettingVC,
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
        
        gradientColorSetting.onFirstColorTap = getOnColorTapLogic(for: IconConfigurationStrings.gradientFistColorPickerTitle.rawValue)
        gradientColorSetting.onSecondColorTap = getOnColorTapLogic(for: IconConfigurationStrings.gradientSecondColorPickerTitle.rawValue)
        gradientColorSettingVC = IconSettingViewController(
            title: IconConfigurationStrings.gradientColorSettingTitle.rawValue,
            isOn: iconConfig.colorConfig?.type == .gradient,
            child: gradientColorSetting,
            onToggle: getOnToggleLogic(for: .gradient)
        )
        
        UIHelpers.add(
            childViewController: gradientColorSettingVC,
            to: gradientColorSection,
            in: self
        )
    }
    
    private func configureImageSetting() {
        view.addSubview(imageSection)
        imageSection.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageSection.topAnchor.constraint(equalTo: gradientColorSection.bottomAnchor, constant: UIHelpers.padding),
            imageSection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageSection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        UIHelpers.addSeparator(below: imageSection, in: view, horizontalPadding: 0)
        
        imageSetting = ImageSettings(text: "Image")
        imageSetting.onImageButtonTapped = { [weak self] in
            guard let self = self else { return }

            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            picker.allowsEditing = false

            self.present(picker, animated: true)
        }
        
        imageSettingVC = IconSettingViewController(
            title: IconConfigurationStrings.imageSettingTitle.rawValue,
            isOn: iconConfig.colorConfig?.type == .image,
            child: imageSetting,
            onToggle: getOnToggleLogic(for: .image)
        )
        
        UIHelpers.add(
            childViewController: imageSettingVC,
            to: imageSection,
            in: self
        )
    }
    
    private func getOnToggleLogic(for colorType: CraftColorType) -> ((Bool) -> Void) {
        return { [weak self] isOn in
            guard let self = self else { return }
            
            if isOn {
                iconConfig.colorConfig?.type = colorType
                switch colorType {
                case .solid:
                    self.gradientColorSettingVC.turnOffIfNeeded()
                    self.imageSettingVC.turnOffIfNeeded()
                case .gradient:
                    self.solidColorIconSettingVC.turnOffIfNeeded()
                    self.imageSettingVC.turnOffIfNeeded()
                case .image:
                    self.solidColorIconSettingVC.turnOffIfNeeded()
                    self.gradientColorSettingVC.turnOffIfNeeded()
                default:
                    break
                }
                
            } else {
                iconConfig.colorConfig?.type = .none
            }
            
            self.updateIconStyleCallback(self.iconConfig)
        }
    }
    
    private func getOnColorTapLogic(for colorPickerTitle: String) -> (() -> Void) {
        return { [weak self] in
            guard let self = self else { return }

            let colorPickerVC = UIColorPickerViewController()
            colorPickerVC.title = colorPickerTitle
            colorPickerVC.delegate = self

            let navController = UINavigationController(rootViewController: colorPickerVC)
            navController.view.backgroundColor = .systemBackground
            colorPickerVC.navigationItem.rightBarButtonItem = UIBarButtonItem(
                barButtonSystemItem: .done,
                target: self,
                action: #selector(self.dismissColorPicker)
            )

            self.present(navController, animated: true)
        }
    }
    
    @objc private func dismissColorPicker() {
        dismiss(animated: true)
    }
}


extension IconConfigSettingsSection: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        switch(viewController.title) {
        case IconConfigurationStrings.solidColorPickerTitle.rawValue:
            iconConfig.colorConfig?.solidColor = viewController.selectedColor
            solidColorSetting.update(color: viewController.selectedColor)
        case IconConfigurationStrings.gradientFistColorPickerTitle.rawValue:
            iconConfig.colorConfig?.gradientColors?[0] = viewController.selectedColor
            gradientColorSetting.updateFirstColor(color: viewController.selectedColor)
        case IconConfigurationStrings.gradientSecondColorPickerTitle.rawValue:
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

extension IconConfigSettingsSection: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)

        if let selectedImage = info[.originalImage] as? UIImage {
            iconConfig.colorConfig?.image = selectedImage
            updateIconStyleCallback(iconConfig)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
          picker.dismiss(animated: true)
    }
}
