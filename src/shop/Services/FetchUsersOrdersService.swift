//
//  FetchUsersOrdersService.swift
//  shop
//
//  Created by Антон Тимонин on 31.05.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

import Foundation
import FirebaseFirestore

class FetchUsersOrdersService {
    private var _orders = [UserOrder]()
    private var requestsCollectionRef: CollectionReference!
    
    public var orders: [UserOrder] {
        return _orders
    }
    
    init() {
        requestsCollectionRef = Firestore.firestore().collection("user-orders")
    }
    
    func fetchData(completion: @escaping () -> ()) {
        //DLog.shared.log(messages: "End fetching requests")
        requestsCollectionRef.getDocuments { [weak self] (snapshot, error) in
            guard error == nil, let snap = snapshot else {
                DLog.shared.log(messages: "Error fetching users-orders")
                completion();
                return }
            
            for admins in snap.documents {
                let data = admins.data()
                
                let userOrder = UserOrder(userOrderID: admins.documentID,
                                          cardnumber: data["cardnumber"] as? String ?? "",
                                          discount: data["discount"] as? Int ?? 0,
                                          family: data["family"] as? String ?? "",
                                          name: data["name"] as? String ?? "",
                                          isCompleted: data["isCompleted"] as? Bool ?? false,
                                          phone: data["phone"] as? String ?? "",
                                          price: data["price"] as? Int ?? 0,
                                          productsID: data["productsID"] as? [Int] ?? [Int]())
                
                if userOrder.isCompleted == false {
                    self?._orders.append(userOrder)
                }
                
            }
            DLog.shared.log(messages: "End fetching users-orders")
            completion()
        }
    }
}
