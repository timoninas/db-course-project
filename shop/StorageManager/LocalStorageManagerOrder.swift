//
//  LocalStorageManagerOrder.swift
//  
//
//  Created by Антон Тимонин on 25.05.2020.
//

import Foundation
import RealmSwift

class LocalStorageManagerOrders {
    
    static func saveObject(_ orderProduct: OrderProduct) {
        try! realm.write {
            realm.add(orderProduct)
        }
    }
    
    static func deleteObject(_ orderProduct: OrderProduct) {
        try! realm.write {
            realm.delete(orderProduct)
        }
        
    }
    
}
