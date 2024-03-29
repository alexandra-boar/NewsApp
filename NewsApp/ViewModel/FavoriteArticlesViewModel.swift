//
//  FavoriteArticleViewModel.swift
//  NewsApp
//
//  Created by Alexandra Boar on 18.01.2024.
//

import Foundation
import UIKit

protocol FavoriteArticlesViewModelDelegate: AnyObject {
    func articlesLoaded(articles: [Article])
    func articlesLoadedWithFailure(error: Error)
}

class FavoriteArticlesViewModel {

    let coreDataManager = CoreDataManager.shared
    let articleService = ArticleServiceAPI()

    weak var delegate: FavoriteArticlesViewModelDelegate?
    private(set) var articles: [Article]?

    init() {
        setupObservers()
    }

    @objc func loadArticles() {
        let articles = coreDataManager.getArticles()
        self.articles = articles
        delegate?.articlesLoaded(articles: articles)
    }

    func getArticle(index: Int) -> Article? {
        if let articles = articles {
            return articles[index]
        } else {
            return nil
        }
    }

    func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(loadArticles), name: Constants.deleteNotification, object: nil)
    }
}
