//
//  Profile.swift
//  shop
//
//  Created by Антон Тимонин on 28.05.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

import Foundation

protocol ProfileProtocol {
    var name: String {get set}
    var family: String {get set}
    var phone: String {get set}
    var cardNumber: String {get set}
}

struct Profile: ProfileProtocol {
    var name: String
    var family: String
    var phone: String
    var cardNumber: String
    
    init() {
        self.name = "Ваше имя"
        self.family = "Ваша фамилия"
        self.phone = "Ваш номер телефона"
        self.cardNumber = "Ваш номер карты"
    }
    
    init(name: String, family: String, phone: String, cardNumber: String) {
        self.name = name
        self.family = family
        self.phone = phone
        self.cardNumber = cardNumber
    }
}

struct Order: ProfileProtocol {
    var name: String
    var family: String
    var phone: String
    var cardNumber: String
    var productsID: [Int]
    var discount: Int
    
    init(name: String, family: String, phone: String, cardnumber: String, productsID: [Int], discount: Int) {
        self.name = name
        self.family = family
        self.phone = phone
        self.cardNumber = cardnumber
        self.productsID = productsID
        self.discount = discount
    }
}
