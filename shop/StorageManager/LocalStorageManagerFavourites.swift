//
//  LocalStorageManagerFavourites.swift
//  shop
//
//  Created by Антон Тимонин on 25.05.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

import Foundation
import RealmSwift

let realm = try! Realm()

class LocalStorageManagerFavourites {
    
    static func saveObject(_ favouriteProduct: FavouriteProduct) {
        try! realm.write {
            realm.add(favouriteProduct)
        }
    }
    
    static func deleteObject(_ favouriteProduct: FavouriteProduct) {
        try! realm.write {
            realm.delete(favouriteProduct)
        } 
    }
}
