//
//  DetailViewModel.swift
//  NewsApp
//
//  Created by Alexandra Boar on 19.12.2023.
//

import Foundation
import UIKit

class DetailViewModel {
    var article: Article?
    let articleService = ArticleServiceAPI()
    
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
