//
//  ArticleServiceAPI.swift
//  NewsApp
//
//  Created by Alexandra Boar on 04.12.2023.
//

import Foundation
import UIKit

class ArticleServiceAPI {
    
    private let url  = Constants.url
    
    func loadArticles(completion: @escaping ([Article]?, Error?) -> ()) {
        let urlRequest = URLRequest(url: url!)
        let request = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let data {
                let decoder = JSONDecoder()
                do {
                    let articlesResponse = try decoder.decode(ArticleResponseModel.self, from: data)
                    completion(articlesResponse.articles, nil)
                } catch let error {
                    print(error)
                    completion(nil, error)
                }
            }
        }
        
        request.resume()
        
    }
}
    

