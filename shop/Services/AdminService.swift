//
//  AdminService.swift
//  shop
//
//  Created by Антон Тимонин on 31.05.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

import Foundation
import FirebaseFirestore

final class AdminService {
    private var requestsCollectionRef = Firestore.firestore().collection("admins")
    private var _isAdmin: Bool = false
    
    public var isAdmin: Bool {
        return _isAdmin
    }
    
    init(isAdminEmail email: String) {
        requestsCollectionRef.getDocuments { [weak self] (snapshot, error) in
            guard error == nil else { return }
            guard let snap = snapshot else { return }
            
            for admins in snap.documents {
                let data = admins.data()
                let checkableEmail = data["email"] as? String ?? "nil"
                if checkableEmail == email {
                    self?._isAdmin = true
                }
            }
        }
    }
}
