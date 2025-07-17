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
    
    private let stackView = UIStackView()

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

        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(fontPicker)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            titleLabel.heightAnchor.constraint(equalToConstant: 24)
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
