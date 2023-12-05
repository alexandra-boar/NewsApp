//
//  ArticlesViewModel.swift
//  NewsApp
//
//  Created by Alexandra Boar on 29.11.2023.
//

import Foundation

class ArticleViewModel {
    
//    var articleData: [Article]?
    
    func loadArticles(completion: @escaping ([Article]?, Error?) -> ()){
        
        let articleService = ArticleServiceAPI()
        
        articleService.loadArticles { articles, error in
            if let articles {
//                print(articles)
//                self.articleData = articles
                completion(articles, nil)
            } else if let error {
                completion(nil, error)
            }
        }
    }
    
}
