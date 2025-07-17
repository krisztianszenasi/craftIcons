//
//  IconConfigSettingsSection.swift
//  CraftIconShowcase
//
//  Created by Krisztián Szénási on 2025. 07. 17..
//

import UIKit

class IconConfigSettingsSection: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 1000)
        ])
    }
}
