//
//  SearchViewController.swift
//  PixabayYIT
//
//  Created by Nikita Koniukh on 14/02/2023.
//

import UIKit

class SearchViewController: UIViewController {
    private let searchImagesListView = SearchImagesListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setColors()
        addConstraints()
    }
    
    private func setupView() {
        title = "Search Images"
        view.addSubview(searchImagesListView)
    }
    
    private func setColors() {
        view.backgroundColor = .systemBackground
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            searchImagesListView.topAnchor.constraint(equalTo: view.topAnchor),
            searchImagesListView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            searchImagesListView.leftAnchor.constraint(equalTo: view.leftAnchor),
            searchImagesListView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
}
