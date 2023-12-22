//
//  DetailViewController.swift
//  NewsApp
//
//  Created by Alexandra Boar on 05.12.2023.
//

import UIKit

class DetailViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var detailTextView: UITextView!
    
    var articleContent: String?
    var articleAuthor: String? {
        didSet {
            title = articleAuthor
        }
    }
    var articleImage: UIImage?
    var imageURLString: String?
    var articleURLString: String?
    var detailViewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        setConstraints()
        configureTextView()
        loadImage(with: imageURLString)
    }
    
    func configureTextView() {
        guard let articleContent, let articleURLString else {
            return
        }
        detailTextView.delegate = self
        detailTextView.isEditable = false
        detailTextView.isUserInteractionEnabled = true
        let attributedString = NSMutableAttributedString(string: articleContent)
        let attributedRange = (attributedString.string as NSString).range(of: "chars")
        let urlString = articleURLString
        attributedString.setAttributes([.link: urlString], range: attributedRange)
        detailTextView.attributedText = attributedString
        detailTextView.font = UIFont.systemFont(ofSize: 17)
        self.detailTextView.linkTextAttributes = [
            .foregroundColor: UIColor.blue,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
    }
    
    func loadImage(with string: String?) {
        guard let string else {
            let defaultImage = UIImage(named: "defaultImage")
            self.articleImageView.image = defaultImage
            return
        }
        detailViewModel.loadImage(urlString: string) { image in
            if let image {
                DispatchQueue.main.async {
                    self.articleImage = image
                    self.articleImageView.image = self.articleImage
                }
            } else {
                let defaultImage = UIImage(named: "defaultImage")
                self.articleImageView.image = defaultImage
            }
        }
    }
    
    func setConstraints() {
        articleImageView.translatesAutoresizingMaskIntoConstraints = false
        detailTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            articleImageView.leadingAnchor.constraint(equalTo: containerView.layoutMarginsGuide.leadingAnchor, constant: 0),
            articleImageView.trailingAnchor.constraint(equalTo: containerView.layoutMarginsGuide.trailingAnchor, constant: 0),
            articleImageView.topAnchor.constraint(equalTo: containerView.layoutMarginsGuide.topAnchor, constant: 0),
            articleImageView.bottomAnchor.constraint(equalTo: detailTextView.layoutMarginsGuide.topAnchor, constant: 0),
            articleImageView.heightAnchor.constraint(equalToConstant: 250),
            
            detailTextView.leadingAnchor.constraint(equalTo: containerView.layoutMarginsGuide.leadingAnchor, constant: 0),
            detailTextView.trailingAnchor.constraint(equalTo: containerView.layoutMarginsGuide.trailingAnchor, constant: 0),
            detailTextView.bottomAnchor.constraint(equalTo: containerView.layoutMarginsGuide.bottomAnchor, constant: 0),
            detailTextView.heightAnchor.constraint(equalToConstant: 500)
            
        ])
        
    }
    
}

extension DetailViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        let webViewController = ArticleWebViewController(url: URL)
        let navController = UINavigationController(rootViewController: webViewController)
        navController.navigationBar.topItem?.title = self.articleAuthor ?? "News"
        present(navController, animated: true)
        return false
    }
}




