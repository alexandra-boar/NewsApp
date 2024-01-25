//
//  ViewController.swift
//  NewsApp
//
//  Created by Alexandra Boar on 29.11.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var articleViewModel = ArticleViewModel()
    
    let defaults = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: Constants.newsTableCellIdentifier, bundle: nil), forCellReuseIdentifier: Constants.newsTableCellIdentifier)
        
        articleViewModel.loadArticles { error in
            if let error {
                print(error)
            } else {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        self.parent?.title = "News"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articleViewModel.getNumberOfArticles()
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.newsTableCellIdentifier, for: indexPath) as! CustomTableViewCell
        cell.configureCell(viewModel: articleViewModel, indexPath: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CustomTableViewCell
        
        guard let urlKey = articleViewModel.getArticleUrl(index: indexPath.row) else {
            print("Could not find urlKey")
            return
        }
        UserDefaults.standard.setValue(cell.isSelected, forKey: urlKey)
        
        print("Article URL: \(articleViewModel.getArticleUrl(index: indexPath.row) ?? "Can't find Article URL")" )
        let articleURL = articleViewModel.getArticleUrl(index: indexPath.row)
        
        cell.checkmarkImage.image = UIImage(systemName: Constants.checkedImage)
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: Constants.detailViewIdentifier) as? DetailViewController {
            
            vc.articleDescription = articleViewModel.getArticleDescription(index: indexPath.row)
            vc.articleAuthor = articleViewModel.getArticleAuthor(index: indexPath.row)
            vc.articleURLString = articleViewModel.getArticleUrl(index: indexPath.row)
            let imageURL = articleViewModel.getImageUrl(index: indexPath.row)
            vc.imageURLString = imageURL
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

