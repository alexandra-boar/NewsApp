//
//  DetailViewController.swift
//  NewsApp
//
//  Created by Alexandra Boar on 05.12.2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var detailTextView: UITextView!
    
    var articleDescription: String?
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
        navigationController?.navigationBar.prefersLargeTitles = true
        setConstraints()
        configureTextView()
        loadImage(with: imageURLString)
    }
   
    func configureTextView() {
        guard let articleDescription, let articleURLString else {
            return
        }
        detailTextView.delegate = self
        detailTextView.isEditable = false
        detailTextView.isUserInteractionEnabled = true
        detailTextView.attributedText = detailViewModel.prepareAttributedString(string: articleDescription, urlString: articleURLString)
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
            articleImageView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 0),
            articleImageView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: 0),
            articleImageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: -20),
            articleImageView.bottomAnchor.constraint(equalTo: detailTextView.layoutMarginsGuide.topAnchor, constant: 20),
            articleImageView.heightAnchor.constraint(equalToConstant: 300),
            
            detailTextView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 0),
            detailTextView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: 0),
            detailTextView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: 0)
            
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
