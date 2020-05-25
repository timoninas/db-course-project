//
//  FavouriteViewCell.swift
//  shop
//
//  Created by Антон Тимонин on 25.05.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

import UIKit

class FavouriteViewCell: UICollectionViewCell {
    var product: FavouriteProduct? = FavouriteProduct()
    
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
        
        priceLabel.text = "\(product?.price ?? 0),00 руб."
        nameLabel.text = "\(product?.name ?? "Nah")"
        //        guard mainImageView.i != nil else { return }
        mainImageView.contentMode = .scaleAspectFit
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
