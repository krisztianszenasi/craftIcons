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
    private let updateSpaceNameCallback: (String) -> Void
    
    private var spaceNameSetting: CraftLabeledChildView!
    private var collaboratorsSetting: CraftLabeledChildView!
    
    init(spaceName: String, updateSpaceNameCallback: @escaping (String) -> Void) {
        self.spaceName = spaceName
        self.updateSpaceNameCallback = updateSpaceNameCallback
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        self.configureSpaceNameSetting()
        self.configureCollaboratorsSetting()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureSpaceNameSetting() {
        let spaceNameTextField = CraftTextField()
        spaceNameTextField.delegate = self
        spaceNameTextField.textAlignment = .left
        spaceNameTextField.placeholder = "Set your space name ..."
        spaceNameTextField.text = spaceName
        spaceNameSetting = CraftLabeledChildView(text: "Space Name", child: spaceNameTextField)
        view.addSubview(spaceNameSetting)

        NSLayoutConstraint.activate([
            spaceNameSetting.topAnchor.constraint(equalTo: view.topAnchor),
            spaceNameSetting.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            spaceNameSetting.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            spaceNameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureCollaboratorsSetting() {
        let spaceNameTextField = CraftTextField()
        spaceNameTextField.delegate = self
        spaceNameTextField.textAlignment = .left
        spaceNameTextField.placeholder = "Set your space name ..."
        spaceNameTextField.text = spaceName
        collaboratorsSetting = CraftLabeledChildView(text: "Collaborators", child: spaceNameTextField)
        view.addSubview(collaboratorsSetting)

        NSLayoutConstraint.activate([
            collaboratorsSetting.topAnchor.constraint(equalTo: spaceNameSetting.bottomAnchor, constant: UIHelpers.padding),
            collaboratorsSetting.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collaboratorsSetting.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            spaceNameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])

    }
}

extension SpaceSettignsSectionViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        updateSpaceNameCallback(textField.text ?? "")
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        updateSpaceNameCallback(textField.text ?? "")
    }
}
