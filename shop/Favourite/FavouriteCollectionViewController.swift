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
    private let reuseIdentifier = "cell"
    private var filteredProducts: Results<FavouriteProduct>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredProducts = realm.objects(FavouriteProduct.self)
        
        print("added")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        collectionView.reloadData()
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
        
        return (filteredProducts != nil) ? filteredProducts.count: 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "showFavouriteSubject", for: indexPath) as! FavouriteViewCell
        
        guard indexPath.row < filteredProducts.count else { return UICollectionViewCell() }
        
        let filteredProduct = filteredProducts[indexPath.row]
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
    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

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
