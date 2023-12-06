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
    
    func loadArticles(completion: @escaping (Error?) -> ()){

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
//        print(getArticle(index: index)?.title)
        if let title = getArticle(index: index)?.title {
            return (title)
        } else {
            return (nil)
        }
    }
    
    func getArticleAuthor(index: Int) -> String? {
//        print(getArticle(index: index)?.author)
        if let author = getArticle(index: index)?.author {
            return (author)
        } else {
            return ("Unknown author")
        }
    }
    
    func getArticleContent(index: Int) -> String? {
        print(getArticle(index: index)?.content)
        if let content = getArticle(index: index)?.content {
            return (content)
        } else {
            return ("Could not load content")
        }
    }
}
