//
//  FormOrderService.swift
//  shop
//
//  Created by Антон Тимонин on 29.05.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

import RealmSwift
import FirebaseFirestore
import UIKit

final class FormOrderService {
    // MARK: Private variables
    private var price: Int = 0
    private var discount: Int = 0
    private let profile: Profile
    private let products: Results<OrderProduct>
    private var requestsCollectionRef: CollectionReference!
    
    // MARK: Inits
    init(profile: Profile, products: Results<OrderProduct>, discount: Int) {
        self.profile = profile
        self.products = products
        self.discount = discount
        requestsCollectionRef = Firestore.firestore().collection("user-orders")
    }
    
    // MARK: Private functions
    private func sendOrder(sender: Order) {
        
        
        requestsCollectionRef.addDocument(data: ["name":sender.name,
                                                 "family":sender.family,
                                                 "cardnumber":sender.cardNumber,
                                                 "phone":sender.phone,
                                                 "productsID":sender.productsID,
                                                 "discount":sender.discount,
                                                 "price":price,
                                                 "isCompleted": false,
                                                 "isProcessed":false])
        DLog.shared.log(messages: "order added")
    }
    
    // MARK: Public functions
    func makePersonalOrder() {
        var productsID = [Int]()
        
        for product in products {
            productsID.append(product.id)
            price += product.price
        }
        
        let diffrenece: Double = Double(price * discount / 100)
        price = price - Int(diffrenece)
        
        let order = Order(name: profile.name,
                          family: profile.family,
                          phone: profile.phone,
                          cardnumber: profile.cardNumber,
                          productsID: productsID,
                          discount: discount)
        
        sendOrder(sender: order)
    }
}
