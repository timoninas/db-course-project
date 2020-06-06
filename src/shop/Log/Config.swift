//
//  Config.swift
//  shop
//
//  Created by Антон Тимонин on 05.06.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

import Foundation

class Config {
    static let shared = Config()
    
    var isMainBD = true
    
    private init() {}
}
