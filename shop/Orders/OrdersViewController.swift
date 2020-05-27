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

class OrdersViewController: UIViewController {
    
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
    
    // MARK: Orders Array
    let orders = ["Kek", "Lol", "Arbidol", "Arbidol", "Arbidol", "Arbidol", "Arbidol", "Arbidol", "Arbidol"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredProducts = realm.objects(OrderProduct.self)
        
        self.tableView.dataSource = self
        tableView.delegate = self
        
        nameLabel.text = "Ваше имя"
        familyLabel.text = "Ваша фамилия"
        emailLabel.text = "Ваша почта"
        phoneNumberLabel.text = "Ваш номер телефона"
        cardNumberLabel.text = "Ваш номер карты"
        
        updatePrice()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
        updatePrice()
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
        totalPriceLabel.text = "Итоговая цена: \(_totalPrice) руб."
    }

}

extension OrdersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
