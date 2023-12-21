//
//  DetailViewController.swift
//  NewsApp
//
//  Created by Alexandra Boar on 05.12.2023.
//

import UIKit

class DetailViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    var articleContent: String?
    var articleTitle: String?
    var articleImage: UIImage?
    var imageURLString: String?
    
    var detailViewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        detailLabel.numberOfLines = 0
        navigationController?.navigationBar.prefersLargeTitles = true
      
        if let articleContent {
            detailLabel.text = articleContent
        }
        
        if let imageURLString {
            loadImage(with: imageURLString)
        } else {
            let defaultImage = UIImage(named: "defaultImage")
            self.articleImageView.image = defaultImage
        }
        
        articleImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            articleImageView.leadingAnchor.constraint(equalTo: containerView.layoutMarginsGuide.leadingAnchor, constant: 0),
            articleImageView.trailingAnchor.constraint(equalTo: containerView.layoutMarginsGuide.trailingAnchor, constant: 0),
            articleImageView.topAnchor.constraint(equalTo: containerView.layoutMarginsGuide.topAnchor, constant: 0),
            articleImageView.bottomAnchor.constraint(equalTo: detailLabel.layoutMarginsGuide.topAnchor, constant: -10),
            articleImageView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    func loadImage(with string: String) {
        detailViewModel.loadImage(urlString: string) { image in
            if let image {
                DispatchQueue.main.async {
                    self.articleImage = image
                    self.articleImageView.image = self.articleImage
                }
               
            } else {
                return
            }
        }
    }
    
}

