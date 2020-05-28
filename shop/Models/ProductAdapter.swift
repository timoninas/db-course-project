//
//  ProductAdapter.swift
//  shop
//
//  Created by Антон Тимонин on 28.05.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

import Foundation

class ProductAdapter {
    
    func productToFavouriteProduct(_ product: Product) -> FavouriteProduct {
        let favouriteProduct = FavouriteProduct()
        
        favouriteProduct.id = product.id
        favouriteProduct.imageData = product.imageData!
        favouriteProduct.length = product.length!
        favouriteProduct.name = product.name
        favouriteProduct.price = product.price
        favouriteProduct.type = product.type
        favouriteProduct.weight = product.weight
        favouriteProduct.width = product.width!
        
        return favouriteProduct
    }
    
    func favouriteToOrderProduct(_ favouriteProduct: FavouriteProduct) -> OrderProduct {
        let orderProduct = OrderProduct()
        
        orderProduct.id = favouriteProduct.id
        orderProduct.imageData = favouriteProduct.imageData
        orderProduct.name = favouriteProduct.name
        orderProduct.price = favouriteProduct.price
        orderProduct.type = favouriteProduct.type
        
        return orderProduct
    }
    
    func productToOrderProduct(_ product: Product) -> OrderProduct {
        let favouriteProduct = self.productToFavouriteProduct(product)
        let orderProduct = self.favouriteToOrderProduct(favouriteProduct)
        
        return orderProduct
    }
}
