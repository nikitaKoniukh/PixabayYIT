//
//  SavedImagesViewController.swift
//  PixabayYIT
//
//  Created by Nikita Koniukh on 14/02/2023.
//

import UIKit

class SavedImagesViewController: UIViewController {
    private let savedImagesListView = SavedImagesListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setColors()
        addConstraints()
    }
    
    private func setupView() {
        title = "Your Saved Images"
        view.addSubview(savedImagesListView)
    }
    
    private func setColors() {
        view.backgroundColor = .systemBackground
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            savedImagesListView.topAnchor.constraint(equalTo: view.topAnchor),
            savedImagesListView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            savedImagesListView.leftAnchor.constraint(equalTo: view.leftAnchor),
            savedImagesListView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
}
