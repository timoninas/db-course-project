//
//  PromocodeService.swift
//  shop
//
//  Created by Антон Тимонин on 29.05.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

import Foundation
import FirebaseFirestore

final class PromocodeService {
    // MARK: Private variables
    private var promocodes = [String:Int]()
    private var requestsCollectionRef: CollectionReference!
    
    // MARK: Inits
    required init() {
        requestsCollectionRef = Firestore.firestore().collection("promocodes")
        
        requestsCollectionRef.getDocuments { [weak self] (snapshot, error) in
            guard error == nil else { return }
            guard let snap = snapshot else { return }
            
            for code in snap.documents {
                let data = code.data()
                let comparable = code.documentID
                let value = data["value"] as? Int ?? 0
                self?.promocodes[comparable] = value
            }
        }
    }
    
    // MARK: Public functions
    func checkPromocode(promocode: String) -> Int{
        return promocodes[promocode] ?? 0
    }
}
