//
//  DetailViewModel.swift
//  NewsApp
//
//  Created by Alexandra Boar on 19.12.2023.
//

import Foundation
import UIKit

class DetailViewModel {
    
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
    
    func prepareAttributedString(string: String, urlString: String) -> NSMutableAttributedString {
        let splitContentArray = string.components(separatedBy: ".")
        // Make content an attributed string:
        let attributedStringContent = NSMutableAttributedString(string: string)
        //Create the range taht will display the link
        let linkRange = (attributedStringContent.string as NSString).range(of: splitContentArray[splitContentArray.count - 1])
        //Assign the link to that range
        attributedStringContent.setAttributes([.link: urlString], range: linkRange)
        //replace linkRange text with "Read more"
        attributedStringContent.replaceCharacters(in: linkRange, with: "Read more")
        return attributedStringContent
    }
}
