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
    
    var articleContent: String?
    var articleTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        detailLabel.numberOfLines = 0
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.title = "title"
        
        
        
                if let articleContent {
                    detailLabel.text = articleContent }
                }
    }
