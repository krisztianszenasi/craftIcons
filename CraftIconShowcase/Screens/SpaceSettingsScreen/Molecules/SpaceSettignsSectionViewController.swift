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
    
    private let spaceNameLabel = CraftSecondaryTitleLabel(fontSize: 16)
    private let spaceNameTextField = CraftTextField()
    
    init(spaceName: String, updateSpaceNameCallback: @escaping (String) -> Void) {
        self.spaceName = spaceName
        self.updateSpaceNameCallback = updateSpaceNameCallback
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        self.configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        view.addSubview(spaceNameLabel)
        view.addSubview(spaceNameTextField)
        
        spaceNameLabel.text = "Space Name"
        spaceNameLabel.textColor = .label
        
        spaceNameTextField.delegate = self
        spaceNameTextField.textAlignment = .left
        spaceNameTextField.placeholder = "Set your space name ..."
        spaceNameTextField.text = spaceName
        
        spaceNameLabel.translatesAutoresizingMaskIntoConstraints = false
        spaceNameTextField.translatesAutoresizingMaskIntoConstraints = false
        

        NSLayoutConstraint.activate([
            spaceNameLabel.topAnchor.constraint(equalTo: view.topAnchor),
            spaceNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  4),
            spaceNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            spaceNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            spaceNameTextField.topAnchor.constraint(equalTo: spaceNameLabel.bottomAnchor, constant: 4),
            spaceNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            spaceNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
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
