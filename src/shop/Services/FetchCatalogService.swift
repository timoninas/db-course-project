//
//  FetchCatalogService.swift
//  shop
//
//  Created by Антон Тимонин on 31.05.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

protocol Fetching {
    func fetchData(completion: @escaping () -> ())
}

class FetchService {
    var _products = [Product]()
    public var product: [Product] {
        return _products
    }
}

final class FetchCatalogService: FetchService, Fetching {
    // MARK: Private variables
//    private var _products = [Product]()
    private var requestsCollectionRef: CollectionReference!
    
    // MARK: Public variables
//    public var product: [Product] {
//        return _products
//    }
    
    // MARK:- Inits
    required override init() {
        requestsCollectionRef = Firestore.firestore().collection("catalog-products")
    }
    
    // MARK: Public functions
    func fetchData(completion: @escaping () -> ()) {
        requestsCollectionRef.getDocuments { [weak self] (snapshot, error) in
            if let error = error {
                DLog.shared.log(messages: "Error fetching catalog")
                debugPrint("Error fetching requests: \(error)")
                completion()
            } else {
                guard let snap = snapshot else { completion(); return }
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
                DLog.shared.log(messages: "End fetching catalog")
                completion()
            }
        }
    }
}

final class FetchCatalogServiceA: FetchService, Fetching {
    // MARK: Private variables
    private var ref:DatabaseReference?
    private var databaseHandle: DatabaseHandle?
    
    // MARK: Public variables
    
    // MARK:- Inits
    required override init() {
        ref = Database.database().reference()
    }
    
    // MARK: Public functions
    func fetchData(completion: @escaping () -> ()) {
        self.databaseHandle = self.ref?.child("subject").observe(.value, with: {[weak self] (snapshot) in
            let subjects = snapshot.value as? [[String:Any]]
            //let imageURL = subject?["imageURL"] as? String
            let subjectCount = subjects?.count
            
            for i in 0..<subjectCount! {
                let subject = subjects![i]
                let id = subject["id"] as? Int
                let imageURL = subject["imageURL"] as? String
                let type = subject["type"] as? String
                let length = subject["length"] as? Int
                let name = subject["name"] as? String
                let weight = subject["weight"] as? Int
                let price = subject["price"] as? Int
                let width = subject["width"] as? Int
                
                let product = Product(id: id!, price: price!, type: type!, weight: weight!, length: length!, width: width!, name: name!, imageURLString: imageURL!)
                
                self?._products.append(product)
            }
            completion()
        })
    }
}

