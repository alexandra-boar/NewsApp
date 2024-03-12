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
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: Constants.favoritesCollectionViewCellIdentifier, bundle: nil), forCellWithReuseIdentifier: Constants.favoritesCollectionViewCellIdentifier)
        collectionView.collectionViewLayout = myCollectionViewLayout
        collectionView.decelerationRate = .fast
        favoritesViewModel.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Favorites"
    }

    override func viewWillAppear(_ animated: Bool) {
        favoritesViewModel.loadArticles()
        let articles = favoritesViewModel.articles
        if articles!.count != 0 {
            collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: false)
        }
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoritesCollectionViewCell", for: indexPath) as? FavoritesCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.configureCellInfo(viewModel: favoritesViewModel, indexPath: indexPath.row)

        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeToDelete))
        upSwipe.direction = UISwipeGestureRecognizer.Direction.up
        cell.addGestureRecognizer(upSwipe)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    @objc func swipeToDelete(sender: UISwipeGestureRecognizer) {
        let cell = sender.view as! FavoritesCollectionViewCell
        let index = self.collectionView.indexPath(for: cell)!.item
        guard let article = favoritesViewModel.getArticle(index: index) else {return}
        let articleEntity = CoreDataManager.shared.getArticleEntity(with: article.url!)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .allowAnimatedContent) {
            cell.transform = CGAffineTransform(translationX: 0, y: -500)
        } completion: { done in
            guard let articleEntityURL = articleEntity?.url else { return }
            CoreDataManager.shared.deleteArticle(url: (articleEntityURL))
            cell.transform = CGAffineTransformIdentity
        }
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
