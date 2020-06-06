//
//  ProductOrderCell.swift
//  shop
//
//  Created by Антон Тимонин on 28.05.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

import UIKit

final class ProductOrderCell: UITableViewCell {
    // MARK:_ Public variables
    public var product: OrderProduct? = OrderProduct()
    
    // MARK:- IBOutlets
    @IBOutlet weak var imageViewProduct: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    
    // MARK:- Awake From Nib
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK:- Public methods
    public func setup() {
        guard let image = UIImage(data: product!.imageData) else { return }
        imageViewProduct.layer.borderWidth = 0.25
        imageViewProduct.layer.cornerRadius = 5
        imageViewProduct.image = image
        name.text = product?.name
        price.text = "\(product?.price ?? 0) руб."
    }

    //    override func setSelected(_ selected: Bool, animated: Bool) {
    //        super.setSelected(selected, animated: animated)
    //
    //        // Configure the view for the selected state
    //    }
}
