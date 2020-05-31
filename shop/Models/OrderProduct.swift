//
//  OrderProduct.swift
//  shop
//
//  Created by Антон Тимонин on 28.05.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

import RealmSwift

final class OrderProduct: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var price: Int = 0
    @objc dynamic var type: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var imageData: Data = Data()
    
    convenience init(id: Int, price: Int, type: String, name: String, imageData: Data) {
        self.init()
        self.id = id
        self.price = price
        self.type = type
        self.name = name
        self.imageData = imageData
    }
}
