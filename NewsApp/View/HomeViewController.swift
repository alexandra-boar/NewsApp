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
        articlesTable.register(UINib.init(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        
        viewModel.loadArticles { error in
            if let error {
                print(error)
            } else {
                DispatchQueue.main.async {
                    self.articlesTable.reloadData()
                }
            }
        }
    }
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumberOfArticles()
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        
        let title = viewModel.getArticleTitle(index: indexPath.row)
//        print(title)
        let author = viewModel.getArticleAuthor(index: indexPath.row)
//        print(author)
        
        cell.titleLabel.text = title
        cell.authorLabel.text = author
        return cell
    }
}

