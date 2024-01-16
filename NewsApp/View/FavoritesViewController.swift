//
//  FavoritesViewController.swift
//  NewsApp
//
//  Created by Alexandra Boar on 03.01.2024.
//

import Foundation
import UIKit


class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
        
    let myCollectionViewLayout: UICollectionViewFlowLayout = FavoritesCarouselFlowLayout()
    
    override func viewDidLoad() {
        let screenWidth = UIScreen.main.bounds.width
        let contentInset = (Double(screenWidth) + Constants.favoritesCellWidth)/2
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: Constants.favoritesCollectionViewCellIdentifier, bundle: nil), forCellWithReuseIdentifier: Constants.favoritesCollectionViewCellIdentifier)
        collectionView.collectionViewLayout = myCollectionViewLayout
        collectionView.decelerationRate = .fast
        collectionView.contentInset = UIEdgeInsets(top: 0, left: contentInset, bottom: 0, right: contentInset)
        
    }
}

extension FavoritesViewController: UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoritesCollectionViewCell", for: indexPath) as! FavoritesCollectionViewCell
        cell.favoriteArticleImageView.contentMode = .scaleAspectFill
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10;
    }
}
