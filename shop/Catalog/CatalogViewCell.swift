//
//  CatalogViewCell.swift
//  shop
//
//  Created by Антон Тимонин on 29.04.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

import UIKit
import Kingfisher

final class CatalogViewCell: UICollectionViewCell {
    var product: Product? = Product()
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func didMoveToWindow() {
    }
    
    func setup() {
        if product?.imageData != nil {
            guard let imgData = product?.imageData, let image = UIImage(data: imgData) else { return }
            mainImageView.image = image
        }
        
        if product?.imageURLString != nil {
            guard let url = URL(string: (product?.imageURLString)!) else { return }
            self.mainImageView.kf.setImage(with: url)
        }
        priceLabel.text = "\(product?.price ?? 0),00 руб."
        nameLabel.text = "\(product?.name ?? "Nah")"
        //        guard mainImageView.i != nil else { return }
        mainImageView.contentMode = .scaleAspectFit
    }
    
    @IBAction func likeTapped(_ sender: UIButton) {
        let favouriteProduct = product!.productToFavouriteProduct()
        LocalStorageManagerFavourites.saveObject(favouriteProduct)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}


