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
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        if isFavorite == true {
//            favoritesButton.setImage(UIImage(systemName: Constants.favoriteImage), for: .normal)
//        } else if isFavorite == false {
//            favoritesButton.setImage(UIImage(systemName: Constants.unfavoriteImage), for: .normal)
//        }
//    }

    @IBAction func addToFavorites(_ sender: UIButton) {
        
        isFavorite.toggle()
        
//        if isFavorite == false {
//            sender.setImage(UIImage(systemName: Constants.favoriteImage), for: .normal)
//            isFavorite = true
//        } else if isFavorite == true {
//            sender.setImage(UIImage(systemName: Constants.unfavoriteImage), for: .normal)
//            isFavorite = false
//        }
    }
    
    func configureCell(viewModel: ArticleViewModel, indexPath: IndexPath) {
        
        let title = viewModel.getArticleTitle(index: indexPath.row)
        let author = viewModel.getArticleAuthor(index: indexPath.row)
        let urlKey = viewModel.getArticleUrl(index: indexPath.row)
        let defaults = UserDefaults()
        
        self.titleLabel.text = title
        self.authorLabel.text = author
        
        if defaults.bool(forKey: urlKey!) == true {
            self.checkmarkImage.image = UIImage(systemName: Constants.checkedImage)
        } else {
            self.checkmarkImage.image = UIImage(systemName: Constants.uncheckedImage)
        }
        
        if isFavorite == true {
            favoritesButton.setImage(UIImage(systemName: Constants.favoriteImage), for: .normal)
        } else if isFavorite == false {
            favoritesButton.setImage(UIImage(systemName: Constants.unfavoriteImage), for: .normal)
        }
        }
}
