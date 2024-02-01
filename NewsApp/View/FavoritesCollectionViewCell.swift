//
//  FavoritesCollectionViewCell.swift
//  NewsApp
//
//  Created by Alexandra Boar on 03.01.2024.
//

import UIKit

class FavoritesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var favoriteArticleImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var flipButton: UIButton!
    @IBOutlet weak var gradientView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
        configureFavoriteArticleImageView()
        configureDescriptionLabel()
    }
    
    func configureCellInfo(viewModel: FavoriteArticlesViewModel, indexPath: Int) {
        let article = viewModel.articles![indexPath]
        let articleURL = article.url
        let articleEntity = CoreDataManager.shared.getArticleEntity(with: articleURL!)
        
        titleLabel.text = articleEntity?.title
        authorLabel.text = articleEntity?.author
        if let articleDescription = articleEntity?.articleDescription {
            descriptionLabel.text = articleDescription
        } else {
            descriptionLabel.text = "Could not load content"
        }
        if let articleImage = UIImage(data: (articleEntity?.image)!) {
            favoriteArticleImageView.image = articleImage }
        else {
            favoriteArticleImageView.image = UIImage(named: "defaultImage")
        }
    }
    
    func configureCell() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = UIColor.white
        authorLabel.font = UIFont.boldSystemFont(ofSize: 18)
        authorLabel.textColor = UIColor.white
        self.backgroundColor = UIColor.systemBlue
        self.layer.cornerRadius = 10.0
        flipButton.setTitle("Flip to read", for: .normal)
        flipButton.setTitleColor(.white, for: .normal)
        flipButton.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        flipButton.layer.cornerRadius = 15.0
    }
    
    func configureFavoriteArticleImageView() {
        favoriteArticleImageView.clipsToBounds = true
        favoriteArticleImageView.contentMode = .scaleAspectFill
        favoriteArticleImageView.layer.masksToBounds = true
        favoriteArticleImageView.autoresizingMask  = [.flexibleTopMargin, .flexibleHeight, .flexibleRightMargin, .flexibleLeftMargin, .flexibleTopMargin, .flexibleWidth]
    }
    
    func configureDescriptionLabel() {
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.font = UIFont.systemFont(ofSize: 17)
        descriptionLabel.textColor = UIColor.white
    }
}
