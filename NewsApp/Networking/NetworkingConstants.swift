//
//  Constants.swift
//  NewsApp
//
//  Created by Alexandra Boar on 04.12.2023.
//

import Foundation

struct Constants {
    static let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=e11662c6199e4702b9fdceabac90f561")
    
    static let detailViewIdentifier = "Detail"
    
    static let customCellIdentifier = "CustomTableViewCell"
    
    static let checkedImage = "checkmark.circle.fill"
    
    static let uncheckedImage = "checkmark.circle"
}
