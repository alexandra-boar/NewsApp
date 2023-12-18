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
    
    var articleContent: String?
    var articleTitle: String?
    var articleImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        detailLabel.numberOfLines = 0
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        if let articleImage {
            articleImageView.image = articleImage
        }
        
        if let articleContent {
            detailLabel.text = articleContent
        }
        
        
    }
}

