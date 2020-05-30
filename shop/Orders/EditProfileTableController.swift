//
//  EditProfileTableController.swift
//  shop
//
//  Created by Антон Тимонин on 27.05.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

import UIKit
import FirebaseFirestore

class EditProfileTableController: UITableViewController {
    
    var profile = Profile()
    var email: String = ""
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var familyTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var cardNumberTextField: UITextField!
    
    private var requestsCollectionRef: CollectionReference!
    private var test: CollectionReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestsCollectionRef = Firestore.firestore().collection("users-info")
        test = Firestore.firestore().collection("user-orders")
    }
    
//    func kek() {
//
//        test.getDocuments { (snapshot, error) in
//            guard error == nil else { return }
//            guard let snap = snapshot else { return }
//
//            for product in snap.documents {
//                let data = product.data()
//                //let docID = product.documentID
//
//                let name = data["name"] as? String ?? ""
//                let family = data["family"] as? String ?? ""
//                let cardnumber = data["cardnumber"] as? String ?? ""
//                let products = data["productsID"] as? [Int]
//                let phone = data["phone"] as? String ?? ""
//
//
//                let kek = 0
//            }
//        }
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupTextFields()
    }
    
    func setupTextFields() {
        nameTextField.text = profile.name
        familyTextField.text = profile.family
        phoneNumberTextField.text = profile.phone
        cardNumberTextField.text = profile.cardNumber
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
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
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
