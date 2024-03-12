//
//  TabBarViewController.swift
//  NewsApp
//
//  Created by Alexandra Boar on 05.03.2024.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

        let nav1 = storyboard.instantiateViewController(withIdentifier: "homeNavController")
        let nav2 = storyboard.instantiateViewController(withIdentifier: "favoritesNavController")

        viewControllers = [nav1, nav2]

    }
}
