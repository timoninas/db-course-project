//
//  EditProfileTableController.swift
//  shop
//
//  Created by Антон Тимонин on 27.05.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

import UIKit
import FirebaseFirestore

final class EditProfileTableController: UITableViewController {
    // MARK:- Private variables
    private var requestsCollectionRef: CollectionReference!
    private var test: CollectionReference!
    
    // MARK:- Public variables
    public var profile = Profile()
    public var email: String = ""
    
    //MARK:- IBOutlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var familyTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var cardNumberTextField: UITextField!
    
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestsCollectionRef = Firestore.firestore().collection("users-info")
        test = Firestore.firestore().collection("user-orders")
    }
    
    // MARK:- View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupTextFields()
    }
    
    // MARK:- IBActions
    @IBAction func saveTapped(_ sender: UIButton) {
        let name = nameTextField.text
        let family = familyTextField.text
        let phoneNumber = phoneNumberTextField.text
        let cardNumber = cardNumberTextField.text
        requestsCollectionRef.document(email).setData(["name":name,
                                                       "family":family,
                                                       "phone":phoneNumber,
                                                       "cardnumber":cardNumber])
        
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK:- Public methods
    public func setupTextFields() {
        nameTextField.text = profile.name
        familyTextField.text = profile.family
        phoneNumberTextField.text = profile.phone
        cardNumberTextField.text = profile.cardNumber
    }
    
    // MARK:- Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
}
