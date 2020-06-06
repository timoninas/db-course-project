//
//  LocalStorageManagerOrder.swift
//  
//
//  Created by Антон Тимонин on 25.05.2020.
//

import Foundation
import RealmSwift

final class LocalStorageManagerOrders {
    
    // MARK:- Save object in Realm
    static func saveObject(_ orderProduct: OrderProduct) {
        try! realm.write {
            realm.add(orderProduct)
        }
    }
    
    // MARK:- Delete object from Realm
    static func deleteObject(_ orderProduct: OrderProduct) {
        try! realm.write {
            realm.delete(orderProduct)
        }
    }
}
