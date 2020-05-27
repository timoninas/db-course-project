//
//  ProductOrderCell.swift
//  shop
//
//  Created by Антон Тимонин on 28.05.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

import UIKit

class ProductOrderCell: UITableViewCell {
    
    var product: OrderProduct? = OrderProduct()
    
    @IBOutlet weak var imageViewProduct: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup() {
        guard let image = UIImage(data: product!.imageData) else { return }
        imageViewProduct.image = image
        name.text = product?.name
        price.text = "\(product?.price ?? 0) руб."
    }
    
    override func didMoveToWindow() {
    }

}
