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
    let description: String?
    let content: String?
    let url: String?
    let urlToImage: String?
}
