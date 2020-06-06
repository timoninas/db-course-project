//
//  Prints.swift
//  business-logic
//
//  Created by Антон Тимонин on 29.05.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

import Foundation

class PrintService {
    func printMenu() {
        print("\n[1] - Фильтровать по типу товара\n[2] - Фильтровать по цене\n[3] - Управлять продуктами\n[0] - Выход из программы\n")
    }

    func printMenuForFilterByType() {
        print("\n    [1] - Все вещи\n    [2] - Одежда\n    [3] - Обувь\n    [4] - Аксессуары\n")
    }

    func printMenuForFilterByPrice() {
        print("\n    [1] - По возрастанию цены\n    [2] - По убыванию цены\n")
    }

    func printMenuForManager() {
        print("\n    [1] - Добавить продукт\n    [2] - Удалить продукт\n")
    }

    func printaProducts() {
        print("\nPRODUCTS:")
        var k = -1
        for product in products {
            k += 1
            print(">\(k)< id=\(product.id)  price=\(product.price)  type=\(product.type)  name='\(product.name)'")
        }
    }

    func printProducts() {
        print("\nPRODUCTS:")
        for product in filteredProducts {
            print("id[\(product.id)]  price=\(product.price)  type=\(product.type)  name='\(product.name)'")
        }
    }
}

func makeChoice() -> String? {
    print("Выберите:")
    let choice = readLine()
    
    guard let resultChoice = choice else { return "" }
    return resultChoice
}
