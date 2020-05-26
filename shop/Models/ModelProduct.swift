//
//  Product.swift
//  shop
//
//  Created by Антон Тимонин on 02.05.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

import UIKit

struct Product {
    var id: Int = 0
    var price: Int = 0
    var type: String = ""
    var weight: Int = 0
    var length: Int? = 0
    var width: Int? = 0
    var name: String = ""
    var imageData: Data?
    var imageURLString: String?
    
//    price
//    weight
//    dlina
//    shirina
//    name tovar
//    picture
    
    init() {
        self.type = ""
        self.id = 0
        self.price = 0
        self.weight = 0
        self.length = 0
        self.width = 0
        self.name = ""
        self.imageData = nil
    }
    
    
    init(id: Int, price: Int, type: String, weight: Int, length: Int, width: Int, name: String, imageData: Data) {
        self.type = type
        self.id = id
        self.price = price
        self.weight = weight
        self.length = length
        self.width = width
        self.name = name
        self.imageData = imageData
    }
    
    
    
    init(id: Int, price: Int, type: String, weight: Int, length: Int, width: Int, name: String, imageURLString: String) {
        
        self.id = id
        self.price = price
        self.type = type
        self.weight = weight
        self.length = length
        self.width = width
        self.name = name
        self.imageURLString = imageURLString
    }
    
    func productToFavouriteProduct() -> FavouriteProduct {
        let favouriteProduct = FavouriteProduct()
        favouriteProduct.id = self.id
        favouriteProduct.price = self.price
        favouriteProduct.type = self.type
        favouriteProduct.weight = self.weight
        favouriteProduct.length = self.length!
        favouriteProduct.width = self.width!
        favouriteProduct.name = self.name
        favouriteProduct.imageData = imageData!
        
        return favouriteProduct
    }
}
