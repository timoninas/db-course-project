//
//  AdminDetailOrderController.swift
//  shop
//
//  Created by Антон Тимонин on 31.05.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

import UIKit
import Kingfisher

class AdminDetailOrderController: UIViewController {
    
    public var products = [Product]()

    private var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView() 
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
extension AdminDetailOrderController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        
        let product = products[indexPath.row]

        if product.imageData != nil {
            guard let imgData = product.imageData, let image = UIImage(data: imgData) else { return UITableViewCell()}
            cell?.imageView!.image = image
            cell?.imageView?.layer.cornerRadius = 5
            cell?.imageView?.layer.borderWidth = 0.25
        }
        
        cell?.textLabel!.text = product.name
        cell?.detailTextLabel!.text = "\(product.price).00 руб."
        
        return cell!
    }
}

// MARK:- Delegate
extension AdminDetailOrderController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
