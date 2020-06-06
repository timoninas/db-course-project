//
//  PorductManager.swift
//  lab3
//
//  Created by Антон Тимонин on 05.06.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

import Foundation

class ProductsManager {
    
    func appendProduct(newElement: Product) {
        products.append(newElement)
    }
    
    func deleteProduct(at index: Int) {
        if index >= 0 && index < filteredProducts.count {
            products.remove(at: index)
            filteredProducts = products
        }
    }
}
