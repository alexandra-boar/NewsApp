//
//  FavoriteArticleViewModel.swift
//  NewsApp
//
//  Created by Alexandra Boar on 18.01.2024.
//

import Foundation

protocol FavoriteArticlesViewModelDelegate: AnyObject {
    func articlesLoaded(articles: [Article])
    func articlesLoadedWithFailure(error: Error)
}

class FavoriteArticlesViewModel {
    
    let coreDataManager = CoreDataManager.shared
    
    weak var delegate: FavoriteArticlesViewModelDelegate?
    private(set) var articles: [Article]?
    
    func loadArticles() {
        let articles = coreDataManager.getArticles()
        self.articles = articles
        delegate?.articlesLoaded(articles: articles )
    }
    
    func addArticle(article: Article) {
        coreDataManager.addArticle(article: article)
        loadArticles()
    }
}
