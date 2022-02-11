//
//  ViewController.swift
//  PersonApp
//
//  Created by Pandos on 10.02.2022.
//

import UIKit

protocol NewChildrenVCDelegate {
    func saveChildren(at indexPath: IndexPath, children: Children)
}

protocol DeleteRowDelegate {
    func deleteRowForIndex(at indexPath: IndexPath)
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var ageView: UIView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var ageTF: UITextField!
    @IBOutlet weak var addButtonOutlet: UIButton!
    @IBOutlet weak var clearButtonOutlet: UIButton!
        
    private var childrens: [Children] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGesture()
        setupNavigationItem()
        setupNameView()
        setupAgeView()
        setupClearButton()
        setupAddButton()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleKeyboard(notification:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleKeyboard(notification:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
   

    
// MARK: - IBActions
    
    @IBAction func addButtonAction() {
        let children = Children(name: nil, age: nil)
        childrens.append(children)
        tableView.reloadData()
        if childrens.count == 5 {
           addButtonOutlet.isHidden = true
      }
    }
    
    @IBAction func cleaerButtonAction() {
        showAlert()
    }
}

// MARK: - UITAbleViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        childrens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChildrenCell
        let children = childrens[indexPath.row]
        cell.delegate = self
        cell.deleteDelegate = self
        cell.indexPath = indexPath
        cell.viewCell()
        cell.configure(child: children)
        return cell
    }
}

// MARK: - NewChildrenCellDelegate
extension ViewController: NewChildrenVCDelegate {
    func saveChildren(at indexPath: IndexPath, children: Children) {
        childrens[indexPath.row] = children
        tableView.reloadData()
    }
}

// MARK: - DeleteChildrenCellDelegate
extension ViewController: DeleteRowDelegate {
    func deleteRowForIndex(at indexPath: IndexPath) {
        childrens.remove(at: indexPath.row)
        tableView.reloadData()
        if childrens.count < 5 {
            addButtonOutlet.isHidden = false
        }
    }
}

// MARK: - Alert Controller
extension ViewController {
    private func showAlert() {
        let alert = UIAlertController(title: "Сбросить данные?", message: nil, preferredStyle: .actionSheet)
        let clearButton = UIAlertAction(title: "Сбросить данные", style: .default) { _ in
            self.nameTF.text = ""
            self.ageTF.text = ""
            self.childrens.removeAll()
            self.tableView.reloadData()
        }
        alert.addAction(clearButton)
        let cancelButton = UIAlertAction(title: "Отмена", style: .cancel)
        alert.addAction(cancelButton)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Work with keyboard
extension ViewController {
    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = true
        view.addGestureRecognizer(tapGesture)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc func handleKeyboard(notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: Any],
              let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
              else { return }
        if notification.name == UIResponder.keyboardWillHideNotification {
            tableView.contentInset = UIEdgeInsets.zero
        }
        else {
              tableView.contentInset = UIEdgeInsets(
                top: 0,
                left: 0,
                bottom: keyboardFrame.height,
                right: 0)
        }
    }
}

