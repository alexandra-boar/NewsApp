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
    let favoritesViewModel = FavoriteArticlesViewModel()
    
    override func viewDidLoad() {
        let screenWidth = UIScreen.main.bounds.width
        let contentInset = (Double(screenWidth) + Constants.favoritesCellWidth)/2
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: Constants.favoritesCollectionViewCellIdentifier, bundle: nil), forCellWithReuseIdentifier: Constants.favoritesCollectionViewCellIdentifier)
        collectionView.collectionViewLayout = myCollectionViewLayout
        collectionView.decelerationRate = .fast
        collectionView.contentInset = UIEdgeInsets(top: 0, left: contentInset, bottom: 0, right: contentInset)
        
        favoritesViewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoritesViewModel.loadArticles()
    }
}

extension FavoritesViewController: UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoritesViewModel.articles?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoritesCollectionViewCell", for: indexPath) as! FavoritesCollectionViewCell
        
        cell.favoriteArticleImageView.contentMode = .scaleAspectFill
        
        let article = favoritesViewModel.articles![indexPath.row]
        cell.titleLabel.text = article.title
        cell.authorLabel.text = article.author
        cell.descriptionLabel.text = article.description
        let imageURL = article.urlToImage
        
        func loadImage(with string: String?) {
            guard let string else {
                cell.favoriteArticleImageView.image = UIImage(named: "defaultImage")
                return
            }
            
            // get image from core data
            
            favoritesViewModel.downloadImage(urlString: string) { image in
                if let image {
                    DispatchQueue.main.async {
                        cell.favoriteArticleImageView.image = image
                    }
                } else {
                    cell.favoriteArticleImageView.image = UIImage(named: "defaultImage")
                }
            }
        }
        loadImage(with: imageURL)
        return cell
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}

extension FavoritesViewController: FavoriteArticlesViewModelDelegate {
    func articlesLoaded(articles: [Article]) {
        collectionView.reloadData()
    }
    
    func articlesLoadedWithFailure(error: Error) {
        print(error)
    }
    
}
