//
//  SearchImagesListView.swift
//  PixabayYIT
//
//  Created by Nikita Koniukh on 14/02/2023.
//

import UIKit

class SearchImagesListView: UIView {
    
    private let viewModel = SearchImagesListViewViewModel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        viewModel.fetchImages()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
