//
//  IconFontSettings.swift
//  CraftIconShowcase
//
//  Created by Krisztián Szénási on 2025. 07. 17..
//

import UIKit

class IconFontSettings: UIView {

    private let titleLabel = CraftBodyLabel(textAlignment: .left)
    private var fontSwitcher: CraftOptionSwitcherView!
    
    private let availableFonts = [
        "AvenirNext-Bold",
        "HelveticaNeue",
        "Menlo-Regular",
        "Courier"
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

        titleLabel.text = "Font"
        titleLabel.setContentHuggingPriority(.required, for: .vertical)

        let fontOptions: [CraftOptionSwitcherItem] = availableFonts.map { fontName in
            CraftOptionSwitcherItem(
                shortLabel: getFontLabel(for: fontName),
                titleLabel: fontName,
                onTap: { [weak self] in self?.onFontSelected?(fontName) }
            )
        }

        fontSwitcher = CraftOptionSwitcherView(options: fontOptions)

        let stack = UIStackView(arrangedSubviews: [titleLabel, fontSwitcher])
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            fontSwitcher.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func getFontLabel(for fontName: String) -> String {
        switch fontName {
        case "AvenirNext-Bold": return "Aa"
        case "HelveticaNeue": return "Ss"
        case "Menlo-Regular": return "ØØ"
        case "Courier": return "Rr"
        default: return "Aa"
        }
    }
}
