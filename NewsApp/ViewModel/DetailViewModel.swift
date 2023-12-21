//
//  DetailViewModel.swift
//  NewsApp
//
//  Created by Alexandra Boar on 19.12.2023.
//

import Foundation
import UIKit

class DetailViewModel {
    
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
            return ("Could not load content")
        }
    }
    
    func loadImage(urlString: String, completion: @escaping (UIImage?) -> ()) {
        articleService.loadArticleImage(urlString: urlString) { image in
            if let image {
                completion(image)
            } else {
                print("Couldn't load image in DetailViewModel")
            }
        }
    }
    
    
}
