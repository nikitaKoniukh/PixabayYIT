//
//  SearchImagesListView.swift
//  PixabayYIT
//
//  Created by Nikita Koniukh on 14/02/2023.
//

import UIKit

final class SearchImagesListView: UIView {
    
    private let viewModel = SearchImagesListViewViewModel()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionHeadersPinToVisibleBounds = true
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ImageHitCollectionViewCell.self, forCellWithReuseIdentifier: ImageHitCollectionViewCell.cellId)
        collectionView.register(FooterLoaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterLoaderCollectionReusableView.footerId)
        collectionView.register(HeaderSearchCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderSearchCollectionReusableView.headerId)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        addSubviews(collectionView, spinner)
        setupCollectionView()
        addConstraints()
        showWelcomeLabel()
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func showCollectionView() {
        spinner.stopAnimating()
        collectionView.isHidden = false
        UIView.animate(withDuration: 0.35, animations: { [weak self] in
            self?.collectionView.alpha = 1
        })
    }
    
    private func showLoader() {
        collectionView.restore()
        collectionView.isHidden = true
        collectionView.alpha = 0
        spinner.startAnimating()
    }
    
    private func showWelcomeLabel() {
        collectionView.setEmptyMessage(.initial)
    }
    
    private func showMessageLabel(with message: ResultMessage) {
        collectionView.restore()
        collectionView.setEmptyMessage(message)
    }
}

extension SearchImagesListView: SearchImagesListViewViewModelDelegate {
    func searchFailed(with errorText: String) {
        collectionView.reloadData()
        showCollectionView()
        showMessageLabel(with: .error(errorText: errorText))
    }
    
    func startLoadingInitialHits() {
        showLoader()
    }
    
    func noImagesToShow() {
        collectionView.reloadData()
        showCollectionView()
        showMessageLabel(with: .empty)
    }
    
    func didLoadMoreHits(with newIndexPaths: [IndexPath]) {
        collectionView.performBatchUpdates {
            self.collectionView.insertItems(at: newIndexPaths)
        }
    }
    
    func didLoadInitialHits() {
        showCollectionView()
        collectionView.reloadData()
        collectionView.scrollToItem(at: [0,0], at: .bottom, animated: true)
    }
}
