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

final class OrdersViewController: UIViewController {
    
    // MARK:- Realm DataBase
    private var filteredProducts: Results<OrderProduct>!
    
    // MARK:- TableView
    @IBOutlet weak var tableView: UITableView!
    
    // MARK:- Profile
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var familyLabel: UILabel!
    @IBOutlet weak var emailLabel: UIButton!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var cardNumberLabel: UILabel!
    
    // MARK:- TotalPrice
    private var _totalPrice = 0
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    // MARK:- Profile
    private var profile = Profile()
    
    // MARK:- Firebase handler
    private var requestsCollectionRef: CollectionReference!
    
    // MARK:- Promocode
    private var _promocode: String = ""
    private let promocodeService = PromocodeService()
    
    // MARK:- Admin Service
    var adminService: AdminService?
    
    // MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredProducts = realm.objects(OrderProduct.self)
        self.tableView.dataSource = self
        tableView.delegate = self
        
        nameLabel.text = "Ваше имя"
        familyLabel.text = "Ваша фамилия"
        emailLabel.titleLabel!.text = "Ваша почта"
        phoneNumberLabel.text = "Ваш номер телефона"
        cardNumberLabel.text = "Ваш номер карты"
        
        updatePrice()
        setupEmail()
        
        
        requestsCollectionRef = Firestore.firestore().collection("users-info")
    }
    
    // MARK:- View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
        updatePrice()
        downloadProfile()
    }
    
    //MARK:- IBActions
    @IBAction func logoutTapped(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func promocodeTapped(_ sender: UIBarButtonItem) {
        presentAlertWithTextField()
    }
    
    @IBAction func buyTapped(_ sender: UIButton) {
        let fromOrder = FormOrderService(profile: profile,
                                         products: filteredProducts,
                                         discount: promocodeService.checkPromocode(promocode: _promocode))
        fromOrder.makePersonalOrder()
        for product in filteredProducts {
            LocalStorageManagerOrders.deleteObject(product)
        }
        self.tableView.reloadData()
        updatePrice()
    }
    
    
    @IBAction func adminTapped(_ sender: UIButton) {
//        let adminService = AdminService(isAdminEmail: emailLabel.titleLabel?.text ?? "")
        if adminService!.isAdmin {
            let adminVC = AdminViewController()
            self.navigationController?.pushViewController(adminVC, animated: true)
        }
    }
    
    // MARK:- Private methods
    private func updatePrice() {
        _totalPrice = 0
        for product in filteredProducts {
            _totalPrice += product.price
        }
        
        if _totalPrice == 0 {
            totalPriceLabel.text = "Корзина пуста"
        } else {
            if _promocode != "" {
                let value = promocodeService.checkPromocode(promocode: _promocode)
                let difference: Double = Double((_totalPrice * value) / 100)
                _totalPrice = _totalPrice - Int(difference)
            }
            totalPriceLabel.text = "Итоговая цена: \(_totalPrice) руб."
        }
    }
    
    private func setupEmail() {
        Auth.auth().addStateDidChangeListener { [weak self](auth, user) in
            if let newEmail = user?.email {
                self?.adminService = AdminService(isAdminEmail: newEmail)
                self?.emailLabel.setTitle(newEmail, for: .normal)
            }
        }
    }
    
    private func downloadProfile() {
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
                
                if email == self?.emailLabel.titleLabel?.text {
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
    
    private func setupProfile() {
        self.nameLabel.text = profile.name
        self.familyLabel.text = profile.family
        self.phoneNumberLabel.text = profile.phone
        self.cardNumberLabel.text = profile.cardNumber
    }

    private func presentAlertWithTextField() {
        let alertController = UIAlertController(title: "Введите промокод", message: "", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Промокод"
        }
        let confirmAction = UIAlertAction(title: "OK", style: .default) { [weak alertController] _ in
            guard let alertController = alertController, let textField = alertController.textFields?.first else { return }
            
            self._promocode = textField.text ?? ""
            self.updatePrice()
            //compare the current password and do action here
        }
        alertController.addAction(confirmAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK:- Seague
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editUserInfo" {
            let editProfileVC = segue.destination as! EditProfileTableController
            editProfileVC.profile = profile
            editProfileVC.email = self.emailLabel.titleLabel?.text as! String
        }
    }
}

// MARK:- Delegate
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

// MARK:- Data Source
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
