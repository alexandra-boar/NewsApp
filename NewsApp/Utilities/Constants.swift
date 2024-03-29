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

    static let newsTableCellIdentifier = "CustomTableViewCell"

    static let checkedImage = "checkmark.circle.fill"

    static let uncheckedImage = "checkmark.circle"

    static let favoriteImage = "star.fill"

    static let unfavoriteImage = "star"

    static let favoritesCollectionViewCellIdentifier = "FavoritesCollectionViewCell"

    static let favoritesCellWidth = 300.0
    static let favoritesCellHeight = 380.0

    static let deleteNotification = Notification.Name("favoriteArticleDeleted")

}
