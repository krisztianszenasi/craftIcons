//
//  CraftOptionSwitcherView.swift
//  CraftIconShowcase
//
//  Created by Krisztián Szénási on 2025. 07. 21..
//

import UIKit

struct CraftOptionSwitcherItem {
    let shortLabel: String
    let titleLabel: String
    let onTap: () -> Void
}


class CraftOptionSwitcherView: UIView {

    private var selectedIndex: Int = 0
    private var options: [CraftOptionSwitcherItem] = []
    private var buttons: [CraftButton] = []

    init(options: [CraftOptionSwitcherItem], selectedIndex: Int = 0) {
        super.init(frame: .zero)
        self.options = options
        self.selectedIndex = selectedIndex
        createButtons()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func createButtons() {
        for (index, option) in options.enumerated() {
            let button = (index == selectedIndex) ? makeSelectedOption(for: option) : makeUnselectedOption(for: option)
            button.tag = index
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            buttons.append(button)
            addSubview(button)
        }
    }

    private func makeSelectedOption(for option: CraftOptionSwitcherItem) -> CraftButton {
        return CraftButton(
            title: "\(option.shortLabel) \(option.titleLabel)",
            style: .primary
        )
    }

    private func makeUnselectedOption(for option: CraftOptionSwitcherItem) -> CraftButton {
        return CraftButton(
            title: option.shortLabel,
            style: .secondary
        )
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let intersect: CGFloat = 4
        let height = bounds.height

        // First, calculate the total width used by unselected buttons
        var totalUnselectedWidth: CGFloat = 0
        var selectedButton: UIButton?
        
        for button in buttons {
            if button.tag != selectedIndex {
                button.sizeToFit()
                totalUnselectedWidth += button.bounds.width + 16 + intersect
            } else {
                selectedButton = button
            }
        }

        // Subtract last padding (not needed after last button)
        if buttons.count > 1 {
            totalUnselectedWidth -= intersect
        }

        // Calculate width for selected button
        let selectedButtonWidth = bounds.width - totalUnselectedWidth - intersect
        var currentX: CGFloat = 0

        for button in buttons {
            let buttonWidth: CGFloat
            if button.tag == selectedIndex {
                buttonWidth = selectedButtonWidth
            } else {
                buttonWidth = button.bounds.width + 16
            }

            button.frame = CGRect(x: currentX, y: 0, width: buttonWidth, height: height)
            currentX += buttonWidth + intersect
        }
    }

    @objc private func buttonTapped(_ sender: UIButton) {
        if (sender.tag == selectedIndex) {  return }
        
        let prevButton = buttons[selectedIndex]
        
        buttons[selectedIndex].style = .secondary
        selectedIndex = sender.tag
        buttons[selectedIndex].style = .primary
        buttons[selectedIndex].setTitle("\(options[selectedIndex].shortLabel) \(options[selectedIndex].titleLabel)", for: .normal)
    
        
        options[selectedIndex].onTap()
        setNeedsLayout()
        UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseInOut]) {
            self.layoutIfNeeded()
        }
        
        prevButton.setTitle(options[prevButton.tag].shortLabel, for: .normal)
    }
}
