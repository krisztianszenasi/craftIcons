//
//  SpaceSettignsSectionViewController.swift
//  CraftIconShowcase
//
//  Created by Krisztián Szénási on 2025. 07. 17..
//

import UIKit


import UIKit

class SpaceSettignsSectionViewController: UIViewController {

    private var spaceName: String
    private let updateSpaceName: (String) -> Void  // ✅ FIXED closure

    private let spaceNameLabel = CraftTitleLabel(textAlignment: .left, fontSize: 16)
    private let spaceNameTextField = CraftTextField()

    // ✅ FIXED init syntax
    init(spaceName: String, updateSpaceName: @escaping (String) -> Void) {
        self.spaceName = spaceName
        self.updateSpaceName = updateSpaceName
        super.init(nibName: nil, bundle: nil)
        self.configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        view.addSubview(spaceNameTextField)
        spaceNameTextField.delegate = self
        spaceNameTextField.textAlignment = .left
        spaceNameTextField.placeholder = "Set your space name ..."
        spaceNameTextField.text = spaceName
        spaceNameTextField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            spaceNameTextField.topAnchor.constraint(equalTo: view.topAnchor),
            spaceNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            spaceNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            spaceNameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension SpaceSettignsSectionViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        updateSpaceName(textField.text ?? "")
        textField.resignFirstResponder()
        return true
    }
}
