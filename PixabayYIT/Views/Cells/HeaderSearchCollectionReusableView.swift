//
//  HeaderSearchCollectionReusableView.swift
//  PixabayYIT
//
//  Created by Nikita Koniukh on 16/02/2023.
//

import UIKit

class HeaderSearchCollectionReusableView: UICollectionReusableView {
    static let headerId = "HeaderSearchCollectionReusableView"
    
    let searchBar: UISearchBar = {
       let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(searchBar)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.bottomAnchor.constraint(equalTo: bottomAnchor),
            searchBar.rightAnchor.constraint(equalTo: rightAnchor),
            searchBar.leftAnchor.constraint(equalTo: leftAnchor)
        ])
    }
}
