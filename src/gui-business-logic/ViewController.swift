//
//  ViewController.swift
//  lab3
//
//  Created by Антон Тимонин on 05.06.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK:- IBOutlets
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    private var filterService: FilterService?
    private var productsManager: ProductsManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterService = FilterService(products: filteredProducts)
        productsManager = ProductsManager()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    // MARK:-IBActions
    
    @IBAction func allProductsTapped(_ sender: UIButton) {
        filterService?.makeFilterByType(choice: "all")
        filteredProducts = filterService?.curProducts as! [Product]
        tableView.reloadData()
    }
    
    @IBAction func clothesTapped(_ sender: UIButton) {
        filterService?.makeFilterByType(choice: "clothes")
        filteredProducts = filterService?.curProducts as! [Product]
        tableView.reloadData()
    }
    
    @IBAction func shoesTapped(_ sender: UIButton) {
        filterService?.makeFilterByType(choice: "shoes")
        filteredProducts = filterService?.curProducts as! [Product]
        tableView.reloadData()
    }
    
    @IBAction func accsessTapped(_ sender: UIButton) {
        filterService?.makeFilterByType(choice: "accessories")
        filteredProducts = filterService?.curProducts as! [Product]
        tableView.reloadData()
    }
    
    @IBAction func addProductTapped(_ sender: UIButton) {
        let type = typeTextField.text
        let name = nameTextField.text
        let product = Product(id: products.count,
                              price: Int.random(in: 999...56999),
                              type: type!,
                              weight: Int.random(in: 1...35),
                              length: Int.random(in: 1...35),
                              width: Int.random(in: 1...35),
                              name: name!)
        productsManager?.appendProduct(newElement: product)
        filterService = FilterService(products: products)
        filteredProducts = products
        tableView.reloadData()
    }
    
    @IBAction func deleteProductTapped(_ sender: UIButton) {
        let strNum = idTextField.text
        if let num = Int(strNum!) {
            productsManager?.deleteProduct(at: num)
            filterService = FilterService(products: products)
            filteredProducts = products
            tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let product = filteredProducts[indexPath.row]
        
        cell?.textLabel!.text = "[\(indexPath.row)] \(product.name)"
        cell?.detailTextLabel?.text = product.type
        return cell!
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
}
