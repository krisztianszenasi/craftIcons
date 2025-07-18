//
//  IconFontSettings.swift
//  CraftIconShowcase
//
//  Created by Krisztián Szénási on 2025. 07. 17..
//

import UIKit

class IconFontSettings: UIView {

    private let titleLabel = CraftBodyLabel(textAlignment: .left)
    private let fontSelectorButton = UIButton(type: .system)

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
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        fontSelectorButton.setTitle("Select Font", for: .normal)
        fontSelectorButton.contentHorizontalAlignment = .right
        fontSelectorButton.setContentHuggingPriority(.defaultLow, for: .horizontal)
        fontSelectorButton.addTarget(self, action: #selector(showFontPicker), for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [titleLabel, fontSelectorButton])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    @objc private func showFontPicker() {
        guard let parentVC = findViewController() else { return }

        let alert = UIAlertController(title: "Select Font", message: nil, preferredStyle: .actionSheet)

        for font in availableFonts {
            alert.addAction(UIAlertAction(title: font, style: .default, handler: { _ in
                self.fontSelectorButton.setTitle(font, for: .normal)
                self.onFontSelected?(font)
            }))
        }

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        parentVC.present(alert, animated: true)
    }

    // Helper to get the parent view controller
    private func findViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while let next = responder?.next {
            if let vc = next as? UIViewController {
                return vc
            }
            responder = next
        }
        return nil
    }
}
