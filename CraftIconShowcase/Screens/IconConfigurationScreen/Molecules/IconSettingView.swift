//
//  IconSettingView.swift
//  CraftIconShowcase
//
//  Created by Krisztián Szénási on 2025. 07. 17..
//

import UIKit

class IconSettingViewController: UIViewController {

    private let titleLabel = UILabel()
    private let toggleSwitch = UISwitch()
    private let contentContainer = UIView()
    private let stackView = UIStackView()
    private var onToggle: ((Bool) -> Void)?

    init(title: String, isOn: Bool, child: Any?, onToggle: ((Bool) -> Void)? = nil) {
        self.onToggle = onToggle
        super.init(nibName: nil, bundle: nil)
        toggleSwitch.isOn = isOn
        titleLabel.text = title

        if let viewController = child as? UIViewController {
            UIHelpers.add(childViewController: viewController, to: contentContainer, in: self)
        } else if let view = child as? UIView {
            addChildView(view)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        updateVisibility(animated: false)
    }

    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false

        // Configure stackView
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false

        // Title row
        let titleRow = UIStackView(arrangedSubviews: [titleLabel, toggleSwitch])
        titleRow.axis = .horizontal
        titleRow.spacing = 8
        titleRow.distribution = .equalSpacing
        titleLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        toggleSwitch.setContentHuggingPriority(.required, for: .horizontal)
        
        // Configure content container
        contentContainer.translatesAutoresizingMaskIntoConstraints = false
        contentContainer.clipsToBounds = true

        // Add components to stack
        stackView.addArrangedSubview(titleRow)
        stackView.addArrangedSubview(contentContainer)

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        toggleSwitch.addTarget(self, action: #selector(toggleChanged), for: .valueChanged)
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

    @objc private func toggleChanged() {
        updateVisibility(animated: true)
        onToggle?(toggleSwitch.isOn)
    }

    private func updateVisibility(animated: Bool) {
        let isVisible = toggleSwitch.isOn

        // Hide or show the content immediately (no fade animation)
        contentContainer.isHidden = false // make it visible temporarily to allow animation

        if animated {
            UIView.animate(withDuration: 0.25, animations: {
                self.contentContainer.alpha = isVisible ? 1 : 0
                self.stackView.layoutIfNeeded()
            }, completion: { _ in
                // After resizing, hide it if needed (without animation)
                self.contentContainer.isHidden = !isVisible
                self.contentContainer.alpha = 1
            })
        } else {
            contentContainer.isHidden = !isVisible
        }
    }
}
