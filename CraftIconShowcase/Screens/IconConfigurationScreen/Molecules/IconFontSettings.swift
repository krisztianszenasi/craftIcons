//
//  IconFontSettings.swift
//  CraftIconShowcase
//
//  Created by Krisztián Szénási on 2025. 07. 17..
//

import UIKit

class IconFontSettings: UIView {
    
    private let titleLabel = CraftBodyLabel(textAlignment: .left)
    private let fontPicker = UIPickerView()
    
    private let availableFonts = [
        "AvenirNext-Bold",
        "HelveticaNeue",
        "Menlo-Regular",
        "Courier",
        "Georgia-Bold",
        "Futura-Medium"
    ]
    
    var onFontSelected: ((String) -> Void)?
    
    init() {
        super.init(frame: .zero)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Font family"
        
        fontPicker.dataSource = self
        fontPicker.delegate = self
        
        addSubview(titleLabel)
        addSubview(fontPicker)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        fontPicker.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 24),
            
            fontPicker.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            fontPicker.leadingAnchor.constraint(equalTo: leadingAnchor),
            fontPicker.trailingAnchor.constraint(equalTo: trailingAnchor),
            fontPicker.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension IconFontSettings: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return availableFonts.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return availableFonts[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedFont = availableFonts[row]
        onFontSelected?(selectedFont)
    }
}
