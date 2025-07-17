//
//  GradientColorSetting.swift
//  CraftIconShowcase
//
//  Created by Krisztián Szénási on 2025. 07. 18..
//

import UIKit

class GradientColorSetting: UIView {

    private var firstColorSetting: ColorSetting!
    private var secondColorSetting: ColorSetting!
    
    var onFirstColorTap: (() -> Void)? {
        didSet {
            firstColorSetting?.onColorTap = onFirstColorTap
        }
    }
    var onSecondColorTap: (() -> Void)? {
        didSet {
            secondColorSetting?.onColorTap = onSecondColorTap
        }
    }
    
    init(firstColor: UIColor, secondColor: UIColor) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        firstColorSetting = ColorSetting(text: "Select First Color", color: firstColor)
        secondColorSetting = ColorSetting(text: "Select Second Color", color: secondColor)
        layout()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateFirstColor(color: UIColor) {
        firstColorSetting.update(color: color)
    }
    
    func updateSecondColor(color: UIColor) {
        secondColorSetting.update(color: color)
    }
    
    private func layout() {
        let stackView = UIStackView(arrangedSubviews: [firstColorSetting, secondColorSetting])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .fill

        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
