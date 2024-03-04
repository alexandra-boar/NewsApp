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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.newsTableCellIdentifier, for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configureCell(viewModel: articleViewModel, indexPath: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CustomTableViewCell else {return}
        
        guard let urlKey = articleViewModel.getArticleUrl(index: indexPath.row) else {
            print("Could not find urlKey")
            return
        }
        
        UserDefaults.standard.setValue(cell.isSelected, forKey: urlKey)
                
        cell.checkmarkImage.image = UIImage(systemName: Constants.checkedImage)
        
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: Constants.detailViewIdentifier) as? DetailViewController {
        
            detailVC.articleDescription = articleViewModel.getArticleDescription(index: indexPath.row)
            detailVC.articleAuthor = articleViewModel.getArticleAuthor(index: indexPath.row)
            detailVC.articleURLString = articleViewModel.getArticleUrl(index: indexPath.row)
            let imageURL = articleViewModel.getImageUrl(index: indexPath.row)
            detailVC.imageURLString = imageURL
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
