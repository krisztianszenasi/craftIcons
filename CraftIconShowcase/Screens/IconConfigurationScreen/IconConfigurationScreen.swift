//
//  IconConfigurationScreen.swift
//  CraftIconShowcase
//
//  Created by Krisztián Szénási on 2025. 07. 17..
//

import UIKit

class IconConfigurationScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}
