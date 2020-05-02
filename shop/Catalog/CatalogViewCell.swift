//
//  CatalogViewCell.swift
//  shop
//
//  Created by Антон Тимонин on 29.04.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

import UIKit

class CatalogViewCell: UICollectionViewCell {
    var product: Product? = Product()
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func didMoveToWindow() {
        guard let imgData = product?.imageData, let image = UIImage(data: imgData) else { return }
        mainImageView.image = image
        mainImageView.contentMode = .scaleAspectFit
        priceLabel.text = "\(product?.price ?? 0)"
        nameLabel.text = "\(product?.name ?? "Nah")"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
