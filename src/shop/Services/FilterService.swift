//
//  FilterCenter.swift
//  shop
//
//  Created by Антон Тимонин on 30.05.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

final class FilterService {
    // MARK: Private variables
    private var _products = [Product]()
    private var _filteredProducts = [Product]()
    private var _isSorted = false
    
    // MARK: Public variables
    public var isSorted: Bool {
        return _isSorted
    }
    
    init(initProducts: [Product]) {
        self._products = initProducts
        self._filteredProducts = initProducts
    }

    // MARK: Public functions
    func FilterByType(choice: String) -> [Product] {
        self._filteredProducts.removeAll()
        if choice == "all" {
            _filteredProducts = _products.filter({ (product) -> Bool in
                return true
            })
        } else {
            _filteredProducts = _products.filter({
                if $0.type == choice {
                    return true
                }
                return false
            })
        }
        
        return _filteredProducts
    }
    
    func filterByPrice() -> [Product] {
        if isSorted {
            _isSorted = false
            
            _filteredProducts.sort { (product1, product2) -> Bool in
                if product1.price >= product2.price {
                    return true
                }
                return false
            }
        } else {
            _isSorted = true
            
            _filteredProducts.sort { (product1, product2) -> Bool in
                if product1.price < product2.price {
                    return true
                }
                return false
            }
        }
        
        return _filteredProducts
    }
}
