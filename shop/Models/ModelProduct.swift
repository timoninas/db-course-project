//
//  Product.swift
//  shop
//
//  Created by Антон Тимонин on 02.05.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

import UIKit

class Product {
    var id: Int = 0
    var price: Int = 0
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
    
    
    convenience init(id: Int, price: Int, weight: Int, length: Int, width: Int, name: String, imageData: Data) {
        self.init()
        
        self.id = id
        self.price = price
        self.weight = weight
        self.length = length
        self.width = width
        self.name = name
        self.imageData = imageData
    }
    
    convenience init(id: Int, price: Int, weight: Int, length: Int, width: Int, name: String, imageURLString: String) {
        self.init()
        
        self.id = id
        self.price = price
        self.weight = weight
        self.length = length
        self.width = width
        self.name = name
        self.imageURLString = imageURLString
    }
}
