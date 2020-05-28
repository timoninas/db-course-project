//
//  Profile.swift
//  shop
//
//  Created by Антон Тимонин on 28.05.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

import Foundation

struct Profile {
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
