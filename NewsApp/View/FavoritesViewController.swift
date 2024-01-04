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
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: Constants.customCollectionViewCellIdentifier, bundle: nil), forCellWithReuseIdentifier: Constants.customCollectionViewCellIdentifier)
        collectionView.collectionViewLayout = myCollectionViewLayout
        collectionView.decelerationRate = .fast
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 5)
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
        cell.favoriteArticleImageView.contentMode = .scaleAspectFit
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10;
    }
}


