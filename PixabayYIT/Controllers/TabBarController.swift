//
//  TabBarController.swift
//  PixabayYIT
//
//  Created by Nikita Koniukh on 02/02/2023.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }

    private func setupTabs() {
        let searchVC = SearchViewController()
        let savedImagesVC = SavedImagesViewController()
        
        searchVC.navigationItem.largeTitleDisplayMode = .automatic
        savedImagesVC.navigationItem.largeTitleDisplayMode = .automatic
        
        let nav1 = UINavigationController(rootViewController: searchVC)
        let nav2 = UINavigationController(rootViewController: savedImagesVC)
        
        nav1.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Saved Images", image: UIImage(systemName: "photo.on.rectangle.angled"), tag: 1)
        
        for nav in [nav1, nav2] {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        setViewControllers([nav1, nav2], animated: true)
    }
}

