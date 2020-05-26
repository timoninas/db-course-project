//
//  CatalogViewController.swift
//  shop
//
//  Created by Антон Тимонин on 02.05.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import Kingfisher

final class CatalogViewController: UICollectionViewController {
    private let reuseIdentifier = "showSubject"
    var products = [Product]()
    var filteredProducts = [Product]()
    
    var ref:DatabaseReference?
    var databaseHandle: DatabaseHandle?
    private var requestsCollectionRef: CollectionReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        requestsCollectionRef = Firestore.firestore().collection("catalog-products")
        
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
                    
                    self?.products.append(newProduct)
                    self?.filteredProducts.append(newProduct)
                    
                }
                self?.collectionView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    @IBAction func filterButtonTapped(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "You can filtered products", message: "Chose your interest category", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Все товары", style: .default, handler: {action in
            self.makeFilter(choice: "all")
        }))
        alert.addAction(UIAlertAction(title: "Одежда", style: .default, handler: {action in
            self.makeFilter(choice: "clothes")
        }))
        alert.addAction(UIAlertAction(title: "Обувь", style: .default, handler: {action in
            self.makeFilter(choice: "shoes")
        }))
        alert.addAction(UIAlertAction(title: "Аксессуары", style: .default, handler: {action in
            self.makeFilter(choice: "accessories")
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        self.present(alert, animated: true)
        
    }
    
    func makeFilter(choice: String) {
        self.filteredProducts.removeAll()
        if choice == "all" {
            filteredProducts = products.filter({ (product) -> Bool in
                return true
            })
        } else {
            filteredProducts = products.filter({
                if $0.type == choice {
                    return true
                }
                return false
            })
        }
        self.collectionView.reloadData()
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
        return filteredProducts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "showSubject", for: indexPath) as! CatalogViewCell
        
        cell.backgroundColor = #colorLiteral(red: 0.9219360948, green: 0.9164555669, blue: 0.9261488914, alpha: 1)
//        cell.mainImageView.image = nil
        cell.product = filteredProducts[indexPath.item]
        cell.setup()
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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

//        ref = Database.database().reference()
//        self.databaseHandle = self.ref?.child("subject").observe(.value, with: {[weak self] (snapshot) in
//            let subjects = snapshot.value as? [[String:Any]]
//            //let imageURL = subject?["imageURL"] as? String
//            let subjectCount = subjects?.count
//
//            for i in 0..<subjectCount! {
//
//                let subject = subjects![i]
//                let id = subject["id"] as? Int
//                let imageURL = subject["imageURL"] as? String
//                let type = subject["type"] as? String
//                let length = subject["length"] as? Int
//                let name = subject["name"] as? String
//                let weight = subject["weight"] as? Int
//                let price = subject["price"] as? Int
//                let width = subject["width"] as? Int
//
//                let product = Product(id: id!, price: price!, type: type!, weight: weight!, length: length!, width: width!, name: name!, imageURLString: imageURL!)
//
//                self?.products.append(product)
//                self?.filteredProducts.append(product)
//                self?.collectionView.reloadData()
//            }
//        })
