//
//  main.swift
//  business-logic
//
//  Created by Антон Тимонин on 29.05.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

import Foundation

func main() {
    var choice: String?
    var choiceInChoice: String?
    var filterService = FilterService(products: products)
    let productsManager = ProductsManager()
    let printService = PrintService()
    
    while choice != "0" {
        printService.printMenu()
        choice = makeChoice()
        
        switch choice {
        case "1":
            printService.printMenuForFilterByType()
            choiceInChoice = makeChoice()
            switch choiceInChoice {
            case "2":
                choiceInChoice = "clothes"
            case "3":
                choiceInChoice = "shoes"
            case "4":
                choiceInChoice = "accessories"
            default:
                choiceInChoice = "all"
            }
            filterService.makeFilterByType(choice: choiceInChoice!)
            filteredProducts = filterService.curProducts
            printService.printProducts()
        case "2":
            printService.printMenuForFilterByPrice()
            choiceInChoice = makeChoice()
            
            filterService.makeFilterByPrice(choice: choiceInChoice!)
            filteredProducts = filterService.curProducts
            printService.printProducts()
        case "3":
            printService.printMenuForManager()
            choiceInChoice = makeChoice()
            
            switch choiceInChoice {
            case "1":
                choiceInChoice = "clothes"
                print("Введите тип продукта")
                let typeProduct = makeChoice()
                
                print("Введите название продукта")
                let nameProduct = makeChoice()
                let product = Product(id: products.count,
                                      price: Int.random(in: 999...56999),
                                      type: typeProduct!,
                                      weight: Int.random(in: 1...100),
                                      length: Int.random(in: 1...100),
                                      width: Int.random(in: 1...100),
                                      name: nameProduct!)
                productsManager.appendProduct(newElement: product)
                filterService = FilterService(products: products)
                filteredProducts = products
                printService.printProducts()
            case "2":
                printService.printaProducts()
                print("Введите номер продукта")
                let numProduct = makeChoice()
                if let num = Int(numProduct!) {
                    productsManager.deleteProduct(at: num)
                    filterService = FilterService(products: products)
                    filteredProducts = products
                    printService.printaProducts()
                    
                } else {
                    print("Некоректное значение")
                }
            default: break
            }
            
            
        case "0":
            choice = "0"
        default:
            print("Выберите заново")
        }
    }
    
    print("PROGRAMM COMPLETED")
}

main()
