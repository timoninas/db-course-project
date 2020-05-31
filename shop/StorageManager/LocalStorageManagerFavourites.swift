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

final class LocalStorageManagerFavourites {
    
    // MARK:- Save object in Realm
    static func saveObject(_ favouriteProduct: FavouriteProduct) {
        try! realm.write {
            realm.add(favouriteProduct)
        }
    }
    
    // MARK:- Delete object from Realm
    static func deleteObject(_ favouriteProduct: FavouriteProduct) {
        try! realm.write {
            realm.delete(favouriteProduct)
        } 
    }
}
