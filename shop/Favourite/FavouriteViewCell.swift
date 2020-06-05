//
//  FavouriteViewCell.swift
//  shop
//
//  Created by Антон Тимонин on 25.05.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

import UIKit

final class FavouriteViewCell: UICollectionViewCell {
    // MARK:-Public variables
    public var product: FavouriteProduct? = FavouriteProduct()
    public var completion: ((Bool) -> ())?
    
    // MARK:-IBOutlets
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK:-Did Move To Window
    override func didMoveToWindow() {
        likeButton.setImage(UIImage(named: "like"), for: .highlighted)
        likeButton.addTarget(self, action: #selector(deleteFromFavourite(_:)), for: .touchUpInside)
    }
    
    // MARK:- Awake From Nib
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK:-Public functions
    func setup() {
        if product?.imageData != nil {
            guard let imgData = product?.imageData, let image = UIImage(data: imgData) else {
                return
            }
            mainImageView.image = image
        }
        
        priceLabel.text = "\(product?.price ?? 0),00 руб."
        nameLabel.text = "\(product?.name ?? "Nah")"
        mainImageView.contentMode = .scaleAspectFit
    }
    
    
    
    @objc private func deleteFromFavourite(_ sender: UIButton) {
        completion?(true)
        LocalStorageManagerFavourites.deleteObject(product!)
    }
    
    // MARK:- IBActions
    @IBAction func addOrderTapped(_ sender: UIButton) {
        let adapter = ProductAdapter()
        let orderProduct = adapter.favouriteToOrderProduct(product!)
        
        LocalStorageManagerOrders.saveObject(orderProduct)
    }
    
}
