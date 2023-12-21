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
                    //                        print(articlesResponse)
                    completion(articlesResponse.articles, nil)
                } catch let error {
                    print(error)
                    completion(nil, error)
                }
            }
        }
        request.resume()
    }
    
   
    func loadArticleImage(urlString: String, completion: @escaping ( _ image: UIImage?) -> ()) {
        let imageURL = URL(string: urlString)
        let urlRequest = URLRequest(url: imageURL!)
        print(imageURL)
        let request = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse {
                print("statusCode: \(httpResponse.statusCode)")
            }
            
            if let data {
                if let image = UIImage(data: data) {
                    completion(image)
                    return
                } else {
                    print("no image")
                }
            }
            
            
            if let error {
                print("Error \(error)")
                completion(nil)
                return
            }
        }
        request.resume()
    }
}

