//
//  LoginViewController.swift
//  shop
//
//  Created by Антон Тимонин on 03.05.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

import UIKit
import Firebase

final class LoginViewController: UIViewController {
    
    //MARK:- Private variables
    private let segueIdentifier: String = "loginSegue"
    
    //MARK:- IBOutlets
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        
        warningLabel.alpha = 0
        
        Auth.auth().addStateDidChangeListener { [weak self](auth, user) in
            if user != nil {
                self?.performSegue(withIdentifier: (self?.segueIdentifier)!, sender: nil)
            }
        }
    }
    
    //MARK:- View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.warningLabel.text = ""
        self.loginTextField.text = ""
        self.passwordTextField.text = ""
    }
    
    // MARK:- IBActions
    @IBAction func loginTapped(_ sender: UIButton) {
        guard
            let email = loginTextField.text,
            let password = passwordTextField.text,
            email != "",
            password != ""
            else {
                displayWarningLabel(withText: "Информация о пользователе некорректна")
                return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (user, error) in
            if error != nil {
                self?.displayWarningLabel(withText: "Error occured")
                return
            }
            if user != nil {
                self?.performSegue(withIdentifier: (self?.segueIdentifier)!, sender: nil)
                return
            }
            
            self?.displayWarningLabel(withText: "No such user")
        }
    }
    
    @IBAction func registerTapped(_ sender: UIButton) {
        guard
            let email = loginTextField.text,
            let password = passwordTextField.text,
            email != "",
            password != ""
            else {
                displayWarningLabel(withText: "Информация о пользователе некорректна")
                return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (user, error) in
            if error == nil {
                if user != nil {
                    //self?.performSegue(withIdentifier: (self?.segueIdentifier)!, sender: nil)
                } else {
                    print("User is not created")
                }
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    
    //MARK:- OBJ-C Methods
    @objc func keyBoardDidHide(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        let keyBoardFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height + keyBoardFrameSize.height)
        
        (self.view as! UIScrollView).scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyBoardFrameSize.height, right: 0)
    }
    
    @objc func keyBoardDidShow(notification: Notification) {
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height)
    }
    
    // MARK:- Other Functions
    func displayWarningLabel(withText: String) {
        warningLabel.text = withText
        
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { [weak self] in
            self?.warningLabel.alpha = 1
        }) { [weak self] complete in
            self?.warningLabel.alpha = 0
        }
    }
    
    
}
