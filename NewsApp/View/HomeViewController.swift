//
//  ViewController.swift
//  NewsApp
//
//  Created by Alexandra Boar on 29.11.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var articlesTable: UITableView!
    
    var viewModel = ArticleViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        articlesTable.delegate = self
        articlesTable.dataSource = self
        articlesTable.register(UINib.init(nibName: Constants.customCellIdentifier, bundle: nil), forCellReuseIdentifier: Constants.customCellIdentifier)
        
        viewModel.loadArticles { error in
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
        viewModel.getNumberOfArticles()
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.customCellIdentifier, for: indexPath) as! CustomTableViewCell
        
        let title = viewModel.getArticleTitle(index: indexPath.row)
        print(title)
        let author = viewModel.getArticleAuthor(index: indexPath.row)
//        print(author)
        
        cell.titleLabel.text = title
        cell.authorLabel.text = author
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let vc = storyboard?.instantiateViewController(withIdentifier: Constants.detailViewIdentifier) as? DetailViewController {
            vc.articleContent = viewModel.getArticleContent(index: indexPath.row)
            navigationController?.pushViewController(vc, animated: true)
        }
            
    }
}

