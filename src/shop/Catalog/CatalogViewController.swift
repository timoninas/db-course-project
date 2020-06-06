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
    
    // MARK: Private variables
    private let reuseIdentifier = "showSubject"
    private var products = [Product]()
    private var filteredProducts = [Product]()
    
    private var _isSorted = false
    
    private var ref:DatabaseReference?
    private var databaseHandle: DatabaseHandle?
    private var filterService: FilterService?
    private var fetchCatalogService: FetchCatalogService?
    private var requestsCollectionRef: CollectionReference!
    
    // MARK: Public variables
    public var isSorted: Bool {
        return _isSorted
    }
    
    // MARK:-IBOutles
    @IBOutlet weak var sortNavButton: UIBarButtonItem!
    
    // MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        DLog.shared.log(messages: "start did loading")
        let tmpImage = resizeImage(image: #imageLiteral(resourceName: "up"), targetSize: CGSize(width: 21, height: 21))
        sortNavButton.image = tmpImage
        
        let fetchCatalogService = FetchCatalogService()
        fetchCatalogService.fetchData {
            self.products = fetchCatalogService.product
            self.filteredProducts = fetchCatalogService.product
            self.filterService = FilterService(initProducts: self.products)
            self.filteredProducts = self.filterService?.filterByPrice() as! [Product]
            self.collectionView.reloadData()
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
        

        DLog.shared.log(messages: "end did loading")
    }
    
    // MARK:- IBActions
    @IBAction func filterButtonTapped(_ sender: UIBarButtonItem) {
        presentAlertForFilterByType()
    }
    
    @IBAction func sortButtonTapped(_ sender: UIBarButtonItem) {
        filteredProducts = filterService?.filterByPrice() as! [Product]
        collectionView.reloadData()
        switchImageButton(sender)
    }
    
    // MARK:- Functions
    private func presentAlertForFilterByType() {
        let alert = UIAlertController(title: "You can filtered products", message: "Chose your interest category", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Все товары", style: .default, handler: {[weak self] action in
            self?.filteredProducts = self?.filterService?.FilterByType(choice: "all") as! [Product]
            self?.collectionView.reloadData()
            //            self.makeFilterByType(choice: "all")
        }))
        alert.addAction(UIAlertAction(title: "Одежда", style: .default, handler: {[weak self] action in
            self?.filteredProducts = self?.filterService?.FilterByType(choice: "clothes") as! [Product]
            self?.collectionView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Обувь", style: .default, handler: {[weak self] action in
            self?.filteredProducts = self?.filterService?.FilterByType(choice: "shoes") as! [Product]
            self?.collectionView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Аксессуары", style: .default, handler: {[weak self] action in
            self?.filteredProducts = self?.filterService?.FilterByType(choice: "accessories") as! [Product]
            self?.collectionView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        self.present(alert, animated: true)
    }
    
    private func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }

        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
    
    private func switchImageButton(_ sender: UIBarButtonItem) {
        let imageDown = resizeImage(image: #imageLiteral(resourceName: "up"), targetSize: CGSize(width: 21, height: 21))
        let imageUp = resizeImage(image: #imageLiteral(resourceName: "down"), targetSize: CGSize(width: 21, height: 21))
        if sender.image == imageDown {
            sender.image = imageUp
        } else {
            sender.image = imageDown
        }
    }
    
    // MARK:-Seague
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

// MARK: UICollectionViewDataSource
extension CatalogViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredProducts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "showSubject", for: indexPath) as! CatalogViewCell
        
        cell.layer.borderWidth = 0.25
        cell.layer.cornerRadius = 5
        cell.backgroundColor = #colorLiteral(red: 0.9238019586, green: 0.9335535169, blue: 0.9419932961, alpha: 1)
        //        cell.mainImageView.image = nil
        cell.product = filteredProducts[indexPath.item]
        cell.setup()
        return cell
    }
}


// MARK:-Collection Flow Layout
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
