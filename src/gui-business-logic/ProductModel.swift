//
//  ProductModel.swift
//  lab3
//
//  Created by Антон Тимонин on 05.06.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

import Foundation

struct Product {
    var id: Int
    var price: Int
    var type: String
    var weight: Int
    var length: Int
    var width: Int
    var name: String
    
    init(id: Int, price: Int, type: String, weight: Int, length: Int, width: Int, name: String) {
        self.id = id
        self.price = price
        self.type = type
        self.weight = weight
        self.length = length
        self.width = width
        self.name = name
    }
}

var products = [
    Product(id: 0, price: 7999, type: "shoes", weight: 35, length: 21, width: 16, name: "КРОССОВКИ HAVEN"),
    Product(id: 1, price: 8999, type: "shoes", weight: 35, length: 21, width: 16, name: "КРОССОВКИ OZWEEGO"),
    Product(id: 2, price: 3999, type: "shoes", weight: 21, length: 45, width: 20, name: "КРОССОВКИ ДЛЯ БЕГА LITE RACER CLN"),
    Product(id: 3, price: 1999, type: "shoes", weight: 21, length: 45, width: 20, name: "КЕДЫ EASY VULC 2.0"),
    Product(id: 4, price: 29999, type: "shoes", weight: 33, length: 22, width: 11, name: "КРОССОВКИ RS REPLICANT OZWEEGO"),
    Product(id: 5, price: 2999, type: "clothes", weight: 33, length: 22, width: 11, name: "ФУТБОЛКА TREFOIL МОСКВА"),
    Product(id: 6, price: 4999, type: "clothes", weight: 33, length: 22, width: 11, name: "ОЛИМПИЙКА SST"),
    Product(id: 7, price: 9999, type: "clothes", weight: 33, length: 22, width: 11, name: "ПАРКА STADIUM 18"),
    Product(id: 8, price: 39999, type: "clothes", weight: 33, length: 22, width: 11, name: "ПАЛЬТО 424"),
    Product(id: 9, price: 699, type: "clothes", weight: 33, length: 22, width: 11, name: "МАЙКА ДЛЯ ТРЕНИРОВОК"),
    Product(id: 10, price: 3999, type: "accessories", weight: 33, length: 22, width: 11, name: "ФУТБОЛЬНЫЙ МЯЧ UNIFORIA LEAGUE"),
    Product(id: 11, price: 1999, type: "accessories", weight: 33, length: 22, width: 11, name: "КЕПКА ДЛЯ БЕГА AEROREADY MESH"),
    Product(id: 12, price: 3999, type: "accessories", weight: 33, length: 22, width: 11, name: "РЮКЗАК CLASSIC LARGE"),
    Product(id: 13, price: 26999, type: "accessories", weight: 33, length: 22, width: 11, name: "СУМКА-ДЮФФЕЛЬ Y-3 HYBRID"),
    Product(id: 14, price: 399, type: "accessories", weight: 33, length: 22, width: 11, name: "НАБОР ИГЛ ДЛЯ НАСОСА")
]

var filteredProducts = products
