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
        searchImagesListView.delegate = self
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

extension SearchViewController: SearchImagesListViewDelegate {
    func didSelectImage(at indexPath: IndexPath, hits: [Hits]) {
        let viewModel = ImageDetailViewViewModel(hits: hits, selectedIndexPath: indexPath)
        let vc = ImageDetailViewController(viewModel: viewModel)
        showDetailViewController(vc, sender: self)
    }
}
