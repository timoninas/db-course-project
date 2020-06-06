//
//  FilterService.swift
//  lab3
//
//  Created by Антон Тимонин on 05.06.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

import Foundation

class FilterService {
    private var _products: [Product]
    private var _filteredProducts: [Product]
    private var lastFilterByPrice: String = "None"
    
    public var curProducts: [Product] {
        return _filteredProducts
    }
    
    required init(products: [Product]) {
        _products = products
        _filteredProducts = products
    }
    
    func makeFilterByType(choice: String) {
        _filteredProducts.removeAll()
        if choice == "all" {
            _filteredProducts = _products
        } else {
            _filteredProducts = _products.filter { (product) -> Bool in
                if product.type == choice {
                    return true
                }
                return false
            }
        }
        
        if lastFilterByPrice != "None" {
            self.makeFilterByPrice(choice: lastFilterByPrice)
        }
    }
    
    func makeFilterByPrice(choice: String) {
        if choice == "1" {
            lastFilterByPrice = "1"
            _filteredProducts.sort { (product1, product2) -> Bool in
                if product1.price < product2.price {
                    return true
                }
                return false
            }
        } else  if choice == "2"{
            lastFilterByPrice = "2"
            _filteredProducts.sort { (product1, product2) -> Bool in
                if product1.price >= product2.price {
                    return true
                }
                return false
            }
        }
    }
    
    func updateProducts(products: [Product]) {
        _products = products
        _filteredProducts = products
    }
}
