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
        //Split description into an array of sentences
        var splitDescriptionArray = string.components(separatedBy: ".")
        //append the element "Read more" to the array
        splitDescriptionArray.append("Read more")
        //append to string "Read more" to the description
        var appendedString = string
        appendedString.append("Read more")
        // Make description an attributed string:
        let attributedStringDescription = NSMutableAttributedString(string: appendedString)
        //Create the range that will display the link
        let linkRange = (attributedStringDescription.string as NSString).range(of: splitDescriptionArray[splitDescriptionArray.count - 1])
        //Assign the link to that range
        attributedStringDescription.setAttributes([.link: urlString], range: linkRange)
        //replace linkRange text with "Read more"
        attributedStringDescription.replaceCharacters(in: linkRange, with: "Read more")
        return attributedStringDescription
    }
}
