//
//  ArticlesViewModel.swift
//  NewsApp
//
//  Created by Alexandra Boar on 29.11.2023.
//

import Foundation

class ArticleViewModel {
    
    var articleList: [Article]?
    let articleService = ArticleServiceAPI()
    let defaults = UserDefaults.standard
    
    func loadArticles(completion: @escaping (Error?) -> ()) {
        articleService.loadArticles { articles, error in
            if let articles {
                self.articleList = articles
                completion(nil)
            } else if let error {
                completion(error)
            }
        }
    }
    
    private func getArticle(index: Int) -> Article? {
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
    
    func getArticleTitle(index: Int) -> String? {
        if let title = getArticle(index: index)?.title {
            return (title)
        } else {
            return (nil)
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
}
