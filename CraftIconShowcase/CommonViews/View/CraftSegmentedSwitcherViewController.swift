//
//  CraftSegmentedSwitcherViewController.swift
//  CraftIconShowcase
//
//  Created by Krisztián Szénási on 2025. 07. 17..
//

import UIKit

class CraftSegmentedSwitcherViewController: UIViewController {

    private let segmentedControl: UISegmentedControl
       private let contentView = UIView()
       private let views: [UIView]

       init(tabs: [(title: String, view: UIView)]) {
           self.views = tabs.map { $0.view }
           self.segmentedControl = UISegmentedControl(items: tabs.map { $0.title })
           super.init(nibName: nil, bundle: nil)
       }

       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

       override func viewDidLoad() {
           super.viewDidLoad()

           view.backgroundColor = .systemBackground
           configureSegmentedControl()
           configureContentView()
           showSelectedView(index: 0)
       }

       private func configureSegmentedControl() {
           segmentedControl.selectedSegmentIndex = 0
           segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
           segmentedControl.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(segmentedControl)

           NSLayoutConstraint.activate([
               segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
               segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
               segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
           ])
       }

       private func configureContentView() {
           contentView.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(contentView)

           NSLayoutConstraint.activate([
               contentView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
               contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
               contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
               contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
           ])
       }

       @objc private func segmentChanged() {
           showSelectedView(index: segmentedControl.selectedSegmentIndex)
       }

       private func showSelectedView(index: Int) {
           contentView.subviews.forEach { $0.removeFromSuperview() }
           let selectedView = views[index]
           contentView.addSubview(selectedView)
           selectedView.translatesAutoresizingMaskIntoConstraints = false

           NSLayoutConstraint.activate([
               selectedView.topAnchor.constraint(equalTo: contentView.topAnchor),
               selectedView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
               selectedView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
               selectedView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
           ])
       }
}
