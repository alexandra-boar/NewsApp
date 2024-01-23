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
    
    func loadArticles() {
        let articles = coreDataManager.getArticles()
        self.articles = articles
        delegate?.articlesLoaded(articles: articles)
    }
    
    func addArticle(article: Article) {
        coreDataManager.addArticle(article: article)
        loadArticles()
    }
    
    func getImage(urlString: String, completion: @escaping (UIImage?) -> ()) {
//        if let coreDataManager.getArticleEntity(with: <#T##String#>)
    }
    
    func downloadImage(urlString: String, completion: @escaping (UIImage?) -> ()) {
        articleService.loadArticleImage(urlString: urlString) { image in
            if let image, let imageData = image.pngData() {
                self.coreDataManager.saveImage(for: urlString, with: imageData)
                completion(image)
            } else {
                print("Couldn't load image in FavoriteArticlesViewModel")
            }
        }
    }
}
