//
//  CraftButton.swift
//  CraftIconShowcase
//
//  Created by Krisztián Szénási on 2025. 07. 17..
//

import UIKit


enum CraftButtonStyle {
    case primary
    case secondary
}


class CraftButton: UIButton {
    
    var style: CraftButtonStyle! {
        didSet {
            applyStyle()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.style = .primary
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(title: String, style: CraftButtonStyle = .primary) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.style = style
        configure()
    }

    private func configure() {
        layer.cornerRadius = 10
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
        applyStyle()
    }

    private func applyStyle() {
        switch style {
        case .primary:
            setTitleColor(.systemLightBlue, for: .normal)
            backgroundColor = .systemLightBlue.withAlphaComponent(0.1)
        case .secondary:
            setTitleColor(.label, for: .normal)
            backgroundColor = .secondarySystemBackground
        default:
            break
        }
    }
}
