//
//  CatalogViewController.swift
//  shop
//
//  Created by Антон Тимонин on 02.05.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

class CatalogViewController: UICollectionViewController {
    private let reuseIdentifier = "showSubject"
    var products = [Product]()
    
    var ref:DatabaseReference?
    var databaseHandle: DatabaseHandle?
    
    let images = ["nmd1", "zx2", "ultra", "three", "zx2", "zx2", "three", "ultra", "three", "zx2", "nmd1", "zx2", "ultra", "three"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        self.databaseHandle = self.ref?.child("subject").observe(.value, with: {[weak self] (snapshot) in
            let subjects = snapshot.value as? [[String:Any]]
            //let imageURL = subject?["imageURL"] as? String
            let subjectCount = subjects?.count
            
            for i in 0..<subjectCount! {
                let subject = subjects![i]
                let id = subject["id"] as? Int
                let imageURL = subject["imageURL"] as? String
                let length = subject["length"] as? Int
                let name = subject["name"] as? String
                let weight = subject["weight"] as? Int
                let price = subject["price"] as? Int
                let width = subject["width"] as? Int
                
                let product = Product(id: id!, price: price!, weight: weight!, length: length!, width: width!, name: name!, imageURLString: imageURL!)
                print(product)
                print(self?.products)
                
                self?.products.append(product)
                self?.collectionView.reloadData()
            }
        })
        

//        var k = 0
        
//        for nameImage in images {
//            let productImg = UIImage(named: nameImage)
//            let dataImg = productImg?.pngData()
//
//            let product = Product()
//            product.imageData = dataImg
//            product.id = k; k += 1
//            product.length = Int.random(in: 0...150)
//            product.weight = Int.random(in: 0...150)
//            product.width = Int.random(in: 0...150)
//            product.price = Int.random(in: 0...100)
//            product.name = nameImage
//
//            products.append(product)
//        }
    }
    
    
    @IBAction func updateProducts(_ sender: Any) {
        for product in products {
            print(product)
        }
    }
    
    @IBAction func filterButton(_ sender: UIButton) {
    }
    
    @IBAction func sortButton(_ sender: UIButton) {
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return products.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "showSubject", for: indexPath) as! CatalogViewCell
        
        cell.backgroundColor = .gray
        cell.product = products[indexPath.item]
        return cell
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("start kek")
        if segue.identifier == "detailsInfo" {
            let detailVC = segue.destination as! DetailSubjectViewController
            let cell = sender as! CatalogViewCell
            if let product = cell.product {
                detailVC.product = product
            }
        }
    }
}

extension CatalogViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemPerRow: CGFloat = 2
        let paddingWidth = 10 * (itemPerRow)
        let availableWidth: CGFloat = collectionView.frame.width - paddingWidth
        let widthPerItem: CGFloat = availableWidth / itemPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem * 1.65)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
    }
}
