//
//  FetchCatalogService.swift
//  shop
//
//  Created by Антон Тимонин on 31.05.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

import UIKit
import FirebaseFirestore

final class FetchCatalogService {
    // MARK: Private variables
    private var _products = [Product]()
    private var requestsCollectionRef: CollectionReference!
    
    // MARK: Public variables
    public var product: [Product] {
        return _products
    }
    
    // MARK:- Inits
    init() {
        requestsCollectionRef = Firestore.firestore().collection("catalog-products")
        
        fetchData()
    }
    
    // MARK: Public functions
    func fetchData() {
        requestsCollectionRef.getDocuments { [weak self] (snapshot, error) in
            if let error = error {
                debugPrint("Error fetching requests: \(error)")
            } else {
                guard let snap = snapshot else { return }
                for product in snap.documents {
                    let data = product.data()
                    //let docID = product.documentID
                    
                    let id = data["id"] as? Int ?? 0
                    
                    let imageURL = data["imageURL"] as? String ?? ""
                    
                    let url = URL(string: imageURL)
                    let dataImage = try? Data(contentsOf: url!)
                    let name = data["name"] as? String ?? ""
                    let length = data["length"] as? Int ?? 0
                    let price = data["price"] as? Int ?? 0
                    let type = data["type"] as? String ?? ""
                    let weight = data["weight"] as? Int ?? 0
                    let width = data["width"] as? Int ?? 0
                    
                    let newProduct = Product(id: id,
                                             price: price,
                                             type: type,
                                             weight: weight,
                                             length: length,
                                             width: width,
                                             name: name,
                                             imageData: dataImage!)
                    
                    self?._products.append(newProduct)
                }
            }
        }
    }
}
