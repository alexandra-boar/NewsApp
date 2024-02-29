//
//  CustomTableViewCell.swift
//  NewsApp
//
//  Created by Alexandra Boar on 05.12.2023.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var checkmarkImage: UIImageView!
    @IBOutlet weak var favoritesButton: UIButton!

    var index: Int?
    var viewModel: ArticleViewModel?
    var coreDataService = CoreDataManager.shared

    var isFavorite: Bool = false {
        didSet {
            let favoriteImage = isFavorite ? UIImage(systemName: Constants.favoriteImage) : UIImage(systemName: Constants.unfavoriteImage)
            favoritesButton.setImage(favoriteImage, for: .normal)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        checkmarkImage.image = UIImage(systemName: Constants.uncheckedImage)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
        authorLabel.font = UIFont.systemFont(ofSize: 15.0)
    }

    @IBAction func addToFavorites(_ sender: UIButton) {
        guard let viewModel = viewModel, let index = index else { return }
        guard let article = viewModel.getArticle(index: index) else {return}
        if isFavorite == false {
            viewModel.toggleFavoriteForArticle(index: index)
            isFavorite.toggle()
            loadImage(with: article.urlToImage)
        } else {
            let articleEntity = coreDataService.getArticleEntity(with: article.url!)
            coreDataService.deleteArticle(url: (articleEntity?.url)!)
            viewModel.toggleFavoriteForArticle(index: index)
            isFavorite.toggle()
        }
    }

    func loadImage(with string: String?) {
        guard let viewModel = viewModel, let index = index else { return }
        guard let article = viewModel.getArticle(index: index) else {return}
        guard let string else {
            let defaultImage = UIImage(named: "defaultImage")
            let defaultImageData = defaultImage!.pngData()
            self.coreDataService.addArticle(article: article, imageData: defaultImageData!)
            return
        }
        viewModel.downloadImage(urlString: string) { image in
            if let image {
                self.coreDataService.addArticle(article: article, imageData: image)
            }
        }
    }

func configureCell(viewModel: ArticleViewModel, indexPath: Int) {
        self.viewModel = viewModel
        self.index = indexPath
        self.isFavorite = viewModel.isArticleFavorite(index: indexPath)

        let title = viewModel.getArticleTitle(index: indexPath)
        let author = viewModel.getArticleAuthor(index: indexPath)
        let urlKey = viewModel.getArticleUrl(index: indexPath)
        let defaults = UserDefaults()

        self.titleLabel.text = title
        self.authorLabel.text = author

        if let urlKey = urlKey, defaults.bool(forKey: urlKey) == true {
            self.checkmarkImage.image = UIImage(systemName: Constants.checkedImage)
        } else {
            self.checkmarkImage.image = UIImage(systemName: Constants.uncheckedImage)
        }
    }
}
