//
//  AdminViewController.swift
//  shop
//
//  Created by Антон Тимонин on 31.05.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

import UIKit
import FirebaseFirestore

class AdminViewController: UIViewController {

    private var tableView =  UITableView()
    private var products = [Product]()
    private var orders = [UserOrder]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DLog.shared.log(messages: "start did loading")
        
        self.navigationItem.title = "Админ"
        self.view.backgroundColor = .white
        
        setupTableView()
        
        let fetchCatalogService = FetchCatalogService()
        fetchCatalogService.fetchData {
            self.products = fetchCatalogService.product
        }
        
        let fetchUsersOrdersService = FetchUsersOrdersService()
        fetchUsersOrdersService.fetchData {
            self.orders.append(contentsOf: fetchUsersOrdersService.orders)
            self.tableView.reloadData()
        }
        DLog.shared.log(messages: "end did loading")
    }
    
    private func setupTableView() {
        tableView.frame = self.view.frame
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
    }
}

//MARK:- Data Source
extension AdminViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell?.detailTextLabel?.text = "\(orders[indexPath.row].userOrderID)"
        cell?.textLabel?.text = "\(orders[indexPath.row].name) \(orders[indexPath.row].family) \(orders[indexPath.row].price).00 руб."
        return cell!
    }
}

// MARK:- Delegate
extension AdminViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let order = orders[indexPath.row]
        
        let completeAction = UIContextualAction(style: .destructive, title: "Обработан") { [weak self] (_, _, _) in
            let requestsCollectionRef = Firestore.firestore().collection("user-orders").document(order.userOrderID)
            
            requestsCollectionRef.updateData(["isCompleted":true])
            self?.orders.remove(at: indexPath.row)
            self?.tableView.reloadData()
        }
        
        completeAction.backgroundColor = #colorLiteral(red: 0, green: 1, blue: 0.557457149, alpha: 1)
        
        return UISwipeActionsConfiguration(actions: [completeAction])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let adminDetailVC = AdminDetailOrderController()
        let userOrder = orders[indexPath.row].productsID
        var filteredProducts = [Product]()
        
        for number in userOrder {
            for product in products {
                if product.id == number {
                    filteredProducts.append(product)
                }
            }
        }
        adminDetailVC.products = filteredProducts
        self.navigationController?.pushViewController(adminDetailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

