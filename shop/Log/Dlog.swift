//
//  Dlog.swift
//  shop
//
//  Created by Антон Тимонин on 05.06.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

import Foundation

class DLog {
    static let shared = DLog()
    
    private init() { }
    func log(messages: Any..., fullPath: String = #file, line: Int = #line, functionName: String = #function) {
        let file = NSURL.fileURL(withPath: fullPath)
        for message in messages {
            print("\(file.pathComponents.last!):\(line) -> \(functionName) \(message)")
        }
    }
}
