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
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var flipButton: UIButton!
    @IBOutlet weak var gradientView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }
    
    func configureCell() {
        favoriteArticleImageView.clipsToBounds = true
        favoriteArticleImageView.contentMode = .scaleAspectFill
        favoriteArticleImageView.layer.masksToBounds = true
        favoriteArticleImageView.image = UIImage(named: "defaultImage")
        favoriteArticleImageView.autoresizingMask  = [.flexibleTopMargin, .flexibleHeight, .flexibleRightMargin, .flexibleLeftMargin, .flexibleTopMargin, .flexibleWidth]
        titleLabel.text = "Title"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = UIColor.white
        authorLabel.text = "Author"
        authorLabel.font = UIFont.boldSystemFont(ofSize: 18)
        authorLabel.textColor = UIColor.white
        contentLabel.text = "Lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum"
        contentLabel.numberOfLines = 0
        contentLabel.lineBreakMode = .byWordWrapping
        contentLabel.font = UIFont.systemFont(ofSize: 17)
        contentLabel.textColor = UIColor.white
        self.backgroundColor = UIColor.systemBlue
        self.layer.cornerRadius = 10.0
        flipButton.setTitle("Flip to read", for: .normal)
        flipButton.setTitleColor(.white, for: .normal)
        flipButton.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        flipButton.layer.cornerRadius = 15.0
    }

}
