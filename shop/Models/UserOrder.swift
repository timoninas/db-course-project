//
//  UserOrder.swift
//  shop
//
//  Created by Антон Тимонин on 31.05.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

import Foundation

struct UserOrder {
    var userOrderID: String
    var cardnumber: String
    var discount: Int
    var family: String
    var name: String
    var isCompleted: Bool
    var phone: String
    var price: Int
    var productsID: [Int]
    
    init(userOrderID: String,
         cardnumber: String,
         discount: Int,
         family: String,
         name: String,
         isCompleted: Bool,
         phone: String,
         price: Int,
         productsID: [Int]) {
        
        self.userOrderID = userOrderID
        self.cardnumber = cardnumber
        self.discount = discount
        self.family = family
        self.name = name
        self.isCompleted = isCompleted
        self.phone = phone
        self.price = price
        self.productsID = productsID
    }
}
