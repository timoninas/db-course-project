//
//  FavouriteCollectionViewController.swift
//  shop
//
//  Created by Антон Тимонин on 29.04.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

import UIKit
import RealmSwift

final class FavouriteCollectionViewController: UICollectionViewController {
    
    // MARK:-Private variables
    private let reuseIdentifier = "cell"
    private var filteredProducts: Results<FavouriteProduct>!

    // MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredProducts = realm.objects(FavouriteProduct.self)
        
        print("added")
    }
    
    // MARK:- View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        collectionView.reloadData()
    }
}

// MARK:- Collection Data Source
extension FavouriteCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (filteredProducts != nil) ? filteredProducts.count: 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "showFavouriteSubject",
                                                      for: indexPath) as! FavouriteViewCell
        
        guard indexPath.row < filteredProducts.count else { return UICollectionViewCell() }
        
        let filteredProduct = filteredProducts[indexPath.row]
        cell.layer.borderWidth = 0.25
        cell.layer.cornerRadius = 5
        cell.product = filteredProduct
        cell.backgroundColor = #colorLiteral(red: 0.9238019586, green: 0.9335535169, blue: 0.9419932961, alpha: 1)
        cell.setup()
        cell.completion = { [weak self] isDeleted in
            if isDeleted {
                self?.collectionView.deleteItems(at: [indexPath])
            }
        }
        
        return cell
    }
}

// MARK:- Collection Flow Layout
extension FavouriteCollectionViewController: UICollectionViewDelegateFlowLayout {
    
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
