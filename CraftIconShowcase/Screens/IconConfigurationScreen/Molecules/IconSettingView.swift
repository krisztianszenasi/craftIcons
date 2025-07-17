//
//  IconSettingView.swift
//  CraftIconShowcase
//
//  Created by Krisztián Szénási on 2025. 07. 17..
//

import UIKit

class IconSettingView: UIView {

    private var onToggleSetting: ((Bool) -> Void)?

    private let titleLabel = CraftTitleLabel(textAlignment: .left, fontSize: 16)
    private let switchButton = UISwitch()
    private let contentContainer = UIView()
    private var contentContainerHeightConstraint: NSLayoutConstraint?

    init(title: String, isOn: Bool, childView: UIView? = nil, onToggleSetting: ((Bool) -> Void)? = nil) {
        self.onToggleSetting = onToggleSetting
        super.init(frame: .zero)
        titleLabel.text = title
        switchButton.isOn = isOn
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false

        configureTitleLabel()
        configureSwitchButton()
        configureContentContainer()

        if let child = childView {
            addChildView(child)
        }

        updateContentVisibility(animated: false)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.textColor = .label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            titleLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }

    private func configureSwitchButton() {
        addSubview(switchButton)
        switchButton.translatesAutoresizingMaskIntoConstraints = false
        switchButton.isUserInteractionEnabled = true
        switchButton.addTarget(self, action: #selector(handleToggle), for: .valueChanged)

        NSLayoutConstraint.activate([
            switchButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            switchButton.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    private func configureContentContainer() {
        addSubview(contentContainer)
        contentContainer.translatesAutoresizingMaskIntoConstraints = false
        contentContainer.clipsToBounds = true // Hide when collapsed

        contentContainerHeightConstraint = contentContainer.heightAnchor.constraint(equalToConstant: 0)
        contentContainerHeightConstraint?.isActive = true

        NSLayoutConstraint.activate([
            contentContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            contentContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentContainer.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func addChildView(_ view: UIView) {
        contentContainer.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentContainer.topAnchor),
            view.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor)
        ])
    }

    @objc private func handleToggle() {
        updateContentVisibility(animated: false)
        onToggleSetting?(switchButton.isOn)
    }

    private func updateContentVisibility(animated: Bool) {
        let show = switchButton.isOn

        contentContainerHeightConstraint?.isActive = false
        contentContainerHeightConstraint = contentContainer.heightAnchor.constraint(equalToConstant: show ? 120 : 0)
        contentContainerHeightConstraint?.isActive = true

        if animated {
            UIView.animate(withDuration: 0.25) {
                self.layoutIfNeeded()
            }
        } else {
            layoutIfNeeded()
        }
    }
}
