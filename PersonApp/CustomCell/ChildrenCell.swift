//
//  ChildrenCell.swift
//  PersonApp
//
//  Created by Pandos on 10.02.2022.
//

import UIKit

class ChildrenCell: UITableViewCell {

    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var ageView: UIView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var ageTF: UITextField!
    
    var children: Children?
    var indexPath: IndexPath?
    var delegate: NewChildrenVCDelegate?
    var deleteDelegate: DeleteRowDelegate?
    
    func viewCell() {
        nameView.layer.cornerRadius = 5
        nameView.layer.borderColor = #colorLiteral(red: 0.9685427547, green: 0.9686817527, blue: 0.9685124755, alpha: 1)
        nameView.layer.borderWidth = 2
        ageView.layer.borderColor = #colorLiteral(red: 0.9685427547, green: 0.9686817527, blue: 0.9685124755, alpha: 1)
        ageView.layer.borderWidth = 2
        ageView.layer.cornerRadius = 5
    }
    
    func configure(child: Children) {
        children = child
        nameTF.text = children?.name
        if children?.age != nil {
           ageTF.text = String( (self.children?.age)! )
        }
        else if children?.age == nil {
                  ageTF.text = ""
          }
    }
        
    @IBAction func deleteButton() {
       if deleteDelegate != nil, let indexPath = indexPath {
        deleteDelegate!.deleteRowForIndex(at: indexPath)
        }
    }

    @IBAction func nameAddTF(_ sender: UITextField) {
        if delegate != nil, let indexPath = indexPath, children != nil {
           children!.name = nameTF.text
            delegate!.saveChildren(at: indexPath, children: children!)
        }
    }
        
    @IBAction func AgeAddTF(_ sender: UITextField) {
        if delegate != nil, let indexPath = indexPath, children != nil {
           if let ageInt = Int(ageTF.text!) {
           children!.age = ageInt
            }
           delegate!.saveChildren(at: indexPath, children: children!)
        }
    }
    
}
