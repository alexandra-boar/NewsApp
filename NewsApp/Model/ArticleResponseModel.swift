//
//  News.swift
//  NewsApp
//
//  Created by Alexandra Boar on 29.11.2023.
//

import Foundation

struct ArticleResponseModel: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}

struct Article: Codable {
    let author: String?
    let title: String?
    let content: String?
    let url: String?
    let urlToImage: String?
    var isFavorite: Bool = false
    
    enum CodingKeys: CodingKey {
        case author
        case title
        case content
        case url
        case urlToImage
    }
}
