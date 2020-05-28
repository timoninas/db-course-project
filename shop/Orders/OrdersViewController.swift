//
//  OrdersViewController.swift
//  shop
//
//  Created by Антон Тимонин on 03.05.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

import UIKit
import Firebase
import RealmSwift
import FirebaseFirestore

class OrdersViewController: UIViewController {
    
    // MARK:-AdminButton
    @IBOutlet weak var adminButton: UIBarButtonItem!
    var _isAdmin = false
    var isAdmin: Bool {
        return _isAdmin
    }
    
    // MARK:-Realm DataBase
    private var filteredProducts: Results<OrderProduct>!
    
    // MARK:-TableView
    @IBOutlet weak var tableView: UITableView!
    
    // MARK:-Profile
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var familyLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var cardNumberLabel: UILabel!
    
    // MARK:-TotalPrice
    private var _totalPrice = 0
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    // MARK:-Profile
    private var profile = Profile()
    
    // MARK:-Firebase handler
    private var requestsCollectionRef: CollectionReference!
    
    // erhgknejr@mail.ru
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
//        adminButton.hidden = true
        
        filteredProducts = realm.objects(OrderProduct.self)
//
        self.tableView.dataSource = self
        tableView.delegate = self
        
        nameLabel.text = "Ваше имя"
        familyLabel.text = "Ваша фамилия"
        emailLabel.text = "Ваша почта"
        phoneNumberLabel.text = "Ваш номер телефона"
        cardNumberLabel.text = "Ваш номер карты"
        
        updatePrice()
        setupEmail()
        
        requestsCollectionRef = Firestore.firestore().collection("users-info")
        
        if !isAdmin {
            self.navigationItem.leftBarButtonItem = nil
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
        updatePrice()
        downloadProfile()
    }
    
    @IBAction func logoutTapped(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func buyTapped(_ sender: UIButton) {
    }
    
    func updatePrice() {
        _totalPrice = 0
        for product in filteredProducts {
            _totalPrice += product.price
        }
        
        if _totalPrice == 0 {
            totalPriceLabel.text = "Корзина пуста"
        } else {
            totalPriceLabel.text = "Итоговая цена: \(_totalPrice) руб."
        }
    }
    
    func setupEmail() {
        Auth.auth().addStateDidChangeListener { [weak self](auth, user) in
            if self?.emailLabel.text != nil {
                self?.emailLabel.text = user?.email
            }
        }
    }
    
    func downloadProfile() {
        requestsCollectionRef.getDocuments { [weak self] (snapshot, error) in
            //            guard error != nil else { return }
            guard let snap = snapshot else { return }
            
            for user in snap.documents {
                let data = user.data()
                
                let email = user.documentID
                let name = data["name"] as? String ?? "Ваше имя"
                let family = data["family"] as? String ?? "Ваша фамилия"
                let cardNumber = data["cardnumber"] as? String ?? "Ваш номер карты"
                let phone = data["phone"] as? String ?? "Ваш номер телефона"
                
                if email == self?.emailLabel.text {
                    self?.profile.cardNumber = cardNumber
                    self?.profile.name = name
                    self?.profile.family = family
                    self?.profile.phone = phone
                    
                    self?.setupProfile()
                    break
                }
            }
        }
    }
    
    func setupProfile() {
        self.nameLabel.text = profile.name
        self.familyLabel.text = profile.family
        self.phoneNumberLabel.text = profile.phone
        self.cardNumberLabel.text = profile.cardNumber
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editUserInfo" {
            let editProfileVC = segue.destination as! EditProfileTableController
            editProfileVC.profile = profile
            editProfileVC.email = self.emailLabel.text!
        }
    }

}

extension OrdersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let product = filteredProducts[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { (_, _, _) in

            LocalStorageManagerOrders.deleteObject(product)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.updatePrice()
            
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
}

extension OrdersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cellBasket") as! ProductOrderCell
        
        let index = indexPath.row
        let currentProduct = filteredProducts[index]
        cell.product = currentProduct
        cell.setup()
        
        return cell
    }
}
