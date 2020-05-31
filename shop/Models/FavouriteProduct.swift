//
//  FavouriteProduct.swift
//  shop
//
//  Created by Антон Тимонин on 25.05.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

import RealmSwift

final class FavouriteProduct: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var price: Int = 0
    @objc dynamic var weight: Int = 0
    @objc dynamic var length: Int = 0
    @objc dynamic var width: Int = 0
    @objc dynamic var type: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var imageData: Data = Data()
    
    convenience init(id: Int, price: Int, weight: Int, length: Int, width: Int, type: String, name: String, imageData: Data) {
        self.init()
        self.id = id
        self.price = price
        self.weight = weight
        self.length = length
        self.width = width
        self.type = type
        self.name = name
        self.imageData = imageData
    }
}


//var price: Int = 0
//var type: String = ""
//var weight: Int = 0
//var length: Int? = 0
//var width: Int? = 0
//var name: String = ""
//var imageData: Data?
//var imageURLString: String?
