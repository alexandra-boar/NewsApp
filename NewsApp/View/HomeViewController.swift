//
//  ViewController.swift
//  NewsApp
//
//  Created by Alexandra Boar on 29.11.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var articlesTable: UITableView!
    
    var articleViewModel = ArticleViewModel()
    
    let defaults = UserDefaults()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        articlesTable.delegate = self
        articlesTable.dataSource = self
        articlesTable.register(UINib.init(nibName: Constants.customCellIdentifier, bundle: nil), forCellReuseIdentifier: Constants.customCellIdentifier)
        
        articleViewModel.loadArticles { error in
            if let error {
                print(error)
            } else {
                DispatchQueue.main.async {
                    self.articlesTable.reloadData()
                }
            }
        }
        
        self.title = "News"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        articlesTable.delegate = self
        articlesTable.dataSource = self
        articlesTable.register(UINib.init(nibName: Constants.customCellIdentifier, bundle: nil), forCellReuseIdentifier: Constants.customCellIdentifier)

    }
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articleViewModel.getNumberOfArticles()
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.customCellIdentifier, for: indexPath) as! CustomTableViewCell
        cell.configureCell(viewModel: articleViewModel, indexPath: indexPath)
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
        
        cell.checkmarkImage.image = UIImage(systemName: Constants.checkedImage)
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: Constants.detailViewIdentifier) as? DetailViewController {
            vc.articleContent = articleViewModel.getArticleContent(index: indexPath.row)
            vc.title = articleViewModel.getArticleAuthor(index: indexPath.row)
            let imageURL = articleViewModel.getImageUrl(index: indexPath.row)
            vc.imageURLString = imageURL
            self.navigationController?.pushViewController(vc, animated: true)
        }
            
    }
}

