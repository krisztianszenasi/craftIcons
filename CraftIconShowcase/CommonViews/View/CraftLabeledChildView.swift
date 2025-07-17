//
//  CraftLabeledChildView.swift
//  CraftIconShowcase
//
//  Created by Krisztián Szénási on 2025. 07. 17..
//

import UIKit

class CraftLabeledChildView: UIView {

    private let titleLabel = CraftSecondaryTitleLabel(fontSize: 16)
    private let childContainer = UIView()

    init(text: String, child: UIView) {
        super.init(frame: .zero)
        configure(text: text, child: child)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure(text: String, child: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        childContainer.translatesAutoresizingMaskIntoConstraints = false
        child.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.text = text
        titleLabel.textColor = .label

        addSubview(titleLabel)
        addSubview(childContainer)
        childContainer.addSubview(child)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),

            childContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            childContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            childContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            childContainer.bottomAnchor.constraint(equalTo: bottomAnchor),

            child.topAnchor.constraint(equalTo: childContainer.topAnchor),
            child.leadingAnchor.constraint(equalTo: childContainer.leadingAnchor),
            child.trailingAnchor.constraint(equalTo: childContainer.trailingAnchor),
            child.bottomAnchor.constraint(equalTo: childContainer.bottomAnchor)
        ])
    }
}
