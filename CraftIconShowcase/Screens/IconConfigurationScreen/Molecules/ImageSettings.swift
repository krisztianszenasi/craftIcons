//
//  ImageSettings.swift
//  CraftIconShowcase
//
//  Created by Krisztián Szénási on 2025. 07. 18..
//

import UIKit

class ImageSettings: UIView {

    private let titleLabel = CraftBodyLabel(textAlignment: .left)
    private let selectImageButton = UIButton(type: .system)

    var onImageButtonTapped: (() -> Void)?

    init(text: String) {
        super.init(frame: .zero)
        configure(text: text)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure(text: String) {
        translatesAutoresizingMaskIntoConstraints = false

        titleLabel.text = text
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        selectImageButton.setTitle("Select Image", for: .normal)
        selectImageButton.contentHorizontalAlignment = .right
        selectImageButton.setContentHuggingPriority(.defaultLow, for: .horizontal)
        selectImageButton.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [titleLabel, selectImageButton])
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
    
    @objc private func handleButtonTap() {
        onImageButtonTapped?()
    }
}

