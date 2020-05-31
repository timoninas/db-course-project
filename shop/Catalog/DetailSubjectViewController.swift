//
//  DetailSubjectViewController.swift
//  shop
//
//  Created by Антон Тимонин on 02.05.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

import UIKit

final class DetailSubjectViewController: UITableViewController {
    // MARK:- Public variables
    public var product = Product()
    
    // MARK:- IBOutlets
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    // MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        likeButton.addTarget(self, action: #selector(addFavouriteTapped(_:)), for: .touchUpInside)
        likeButton.setImage(UIImage(named: "likeFull"), for: .highlighted)
        
        if product.imageData != nil {
            if let img = UIImage(data: product.imageData!) {
                mainImageView.image = img
            }
        }
        
        if product.imageURLString != nil {
            guard let url = URL(string: (product.imageURLString)!) else { return }
            self.mainImageView.kf.setImage(with: url)
        }
        idLabel.text = "id: \(product.id)"
        nameLabel.text = product.name
        priceLabel.text = "Цена: \(product.price) руб."
        typeLabel.text = "Тип товара: \(product.type)"
        sizeLabel.text = "Размер: \(product.width ?? 0)x\(product.length ?? 0) см"
        weightLabel.text = "Вес: \(product.weight) кг"
    }
    
    // MARK:- IBActions
    @IBAction func addOrderTapped(_ sender: UIButton) {
        let adapter = ProductAdapter()
        let orderProduct = adapter.productToOrderProduct(product)
        
        LocalStorageManagerOrders.saveObject(orderProduct)
    }
    
    // MARK:- OBJ-C methods
    @objc func addFavouriteTapped(_ sender: UIButton) {
        let adapter = ProductAdapter()
        let favouriteProduct = adapter.productToFavouriteProduct(product)
        LocalStorageManagerFavourites.saveObject(favouriteProduct)
    }
}
