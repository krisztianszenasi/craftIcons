//
//  UIHelpers.swift
//  CraftIconShowcase
//
//  Created by Krisztián Szénási on 2025. 07. 16..
//

import UIKit


struct UIHelpers {
    
    static let padding: CGFloat = 20
    
    static func addSeparator(below viewAbove: UIView, in container: UIView, verticalPadding: CGFloat = 20, horizontalPadding: CGFloat = 20) {
        let separator = CraftSeparatorView()
        container.addSubview(separator)
                
        NSLayoutConstraint.activate([
            separator.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: horizontalPadding),
            separator.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -horizontalPadding),
            separator.topAnchor.constraint(equalTo: viewAbove.bottomAnchor, constant: verticalPadding / 2)
        ])
    }
    
    static func addSeparator(above viewBelow: UIView, in container: UIView, verticalPadding: CGFloat = 20, horizontalPadding: CGFloat = 20) {
        let separator = CraftSeparatorView()
        container.addSubview(separator)
        
        NSLayoutConstraint.activate([
            separator.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: horizontalPadding),
            separator.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -horizontalPadding),
            separator.bottomAnchor.constraint(equalTo: viewBelow.topAnchor, constant: -verticalPadding / 2)
        ])
    }
    
    static func add(
        childViewController: UIViewController,
        to containerView: UIView,
        in parentViewController: UIViewController
    ) {
        parentViewController.addChild(childViewController)
        containerView.addSubview(childViewController.view)

        let childView = childViewController.view!
        childView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            childView.topAnchor.constraint(equalTo: containerView.topAnchor),
            childView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            childView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            childView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])

        childViewController.didMove(toParent: parentViewController)
    }
}
