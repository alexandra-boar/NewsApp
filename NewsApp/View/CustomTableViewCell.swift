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
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkmarkImage.image = UIImage(systemName: Constants.checkedImage)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
        authorLabel.font = UIFont.systemFont(ofSize: 15.0)
        
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
        
    }
}
