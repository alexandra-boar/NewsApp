//
//  ArticlesViewModel.swift
//  NewsApp
//
//  Created by Alexandra Boar on 29.11.2023.
//

import UIKit

class ArticleViewModel {
    
    var articleList: [Article]?
    let articleService = ArticleServiceAPI()
    let defaults = UserDefaults.standard
    let coreDataManager = CoreDataManager.shared
    
    
    func loadArticles(completion: @escaping (Error?) -> ()) {
        let managedArticles = coreDataManager.getArticles()
        
        articleService.loadArticles { articles, error in
            if let articles {
                self.articleList = articles.map { article in
                    var favoriteArticle = managedArticles.first { managedArticle in
                        managedArticle.url == article.url
                    }
                    favoriteArticle?.isFavorite.toggle()
                    if let favoriteArticle {
                        return favoriteArticle
                    } else {
                        return article
                    }
                }
                completion(nil)
            } else if let error {
                completion(error)
            }
        }
    }
        
        
        func getArticle(index: Int) -> Article? {
            if let list = articleList {
                return list[index]
            } else {
                return nil
            }
        }
        
        // cell config
        func getNumberOfArticles() -> Int {
            return articleList?.count ?? 0
        }
        
        func toggleFavoriteForArticle(index: Int) {
            articleList?[index].isFavorite.toggle()
        }
        
        func getArticleTitle(index: Int) -> String? {
            if let title = getArticle(index: index)?.title {
                return (title)
            } else {
                return (nil)
            }
        }
        
        func isArticleFavorite(index: Int) -> Bool {
            if let isFavorite = getArticle(index: index)?.isFavorite {
                return isFavorite
            } else {
                return false
            }
        }
        
        
        func getArticleAuthor(index: Int) -> String? {
            if let author = getArticle(index: index)?.author {
                return (author)
            } else {
                return ("Unknown author")
            }
        }
        
        func getArticleContent(index: Int) -> String? {
            if let content = getArticle(index: index)?.content {
                return (content)
            } else {
                return ("Could not load content. Read More")
            }
        }
        
        func getArticleDescription(index: Int) -> String? {
            if let description = getArticle(index: index)?.description {
                return (description)
            } else {
                return ("Could not load content.")
            }
        }
        
        func getArticleUrl(index: Int) -> String? {
            if let url = getArticle(index: index)?.url {
                return (url)
            } else {
                return nil
            }
        }
        
        func getImageUrl(index: Int) -> String? {
            if let imageUrl = getArticle(index: index)?.urlToImage {
                print(imageUrl)
                return (imageUrl)
            } else {
                return nil
            }
        }
    
    func downloadImage(urlString: String, completion: @escaping (Data?) -> ()) {
        articleService.loadArticleImage(urlString: urlString) { image in
            if let image, let imageData = image.pngData() {
                completion(imageData)
            } else {
                print("Couldn't load image in ArticlesViewModel")
            }
        }
    }
        
    
}
