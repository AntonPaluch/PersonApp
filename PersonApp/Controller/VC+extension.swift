//
//  VC+extension.swift
//  PersonApp
//
//  Created by Pandos on 11.02.2022.
//

import UIKit

extension ViewController {
    
    func setupNameView() {
     nameView.layer.cornerRadius = 5
        nameView.layer.borderColor = #colorLiteral(red: 0.9685427547, green: 0.9686817527, blue: 0.9685124755, alpha: 1)
     nameView.layer.borderWidth = 2
    }
    
    func setupAgeView() {
        ageView.layer.cornerRadius = 5
        ageView.layer.borderColor = #colorLiteral(red: 0.9685427547, green: 0.9686817527, blue: 0.9685124755, alpha: 1)
        ageView.layer.borderWidth = 2
    }
    
    func setupClearButton() {
        clearButtonOutlet.layer.cornerRadius = 20
        clearButtonOutlet.layer.borderWidth = 2
        clearButtonOutlet.layer.borderColor = #colorLiteral(red: 0.8454070687, green: 0.05396092683, blue: 0, alpha: 1)
    }
    
    func setupAddButton() {
        addButtonOutlet.layer.cornerRadius = 20
        addButtonOutlet.layer.borderWidth = 2
        addButtonOutlet.layer.borderColor = #colorLiteral(red: 0, green: 0.5904541612, blue: 0.9909005761, alpha: 1)
    }
    
    func setupNavigationItem() {
        let titleLabel = UILabel()
            titleLabel.text = "Персональные данные"
            titleLabel.sizeToFit()
            let leftItem = UIBarButtonItem(customView: titleLabel)
            navigationItem.leftBarButtonItem = leftItem
    }
}
