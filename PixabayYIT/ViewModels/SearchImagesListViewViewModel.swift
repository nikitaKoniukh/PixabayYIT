//
//  SearchImagesListViewViewModel.swift
//  PixabayYIT
//
//  Created by Nikita Koniukh on 14/02/2023.
//

import UIKit

protocol SearchImagesListViewViewModelDelegate: AnyObject {
    func didLoadInitialHits()
}

final class SearchImagesListViewViewModel: NSObject {
    
    private var cellViewModels: [ImageHitCollectionViewCellViewModel] = []
    public weak var delegate: SearchImagesListViewViewModelDelegate?
    
    private var hitsArray: [Hits] = [] {
        didSet {
            for hit in hitsArray {
                let viewModel = ImageHitCollectionViewCellViewModel(previewURLString: hit.previewURL)
                
                if !cellViewModels.contains(viewModel) {
                    cellViewModels.append(viewModel)
                }
            }
        }
    }
    
    public func fetchImages() {
        APIService.shared.execute(.init(searchTerms: ["yellow", "flowers"]), expecting: HitsResponse.self, completion: { [weak self] result in
            switch result {
            case .success(let hitsResponse):
                guard let hits = hitsResponse.hits else {
                    return
                }
                
                self?.hitsArray = hits
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialHits()
                }
            case .failure(let failure):
                print(String(describing: failure))
            }
        })
    }
}

extension SearchImagesListViewViewModel: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageHitCollectionViewCell.cellId, for: indexPath) as? ImageHitCollectionViewCell else {
            fatalError("No suported cell")
        }
        
        let viewModel = cellViewModels[indexPath.item]
        cell.configure(with: viewModel)
        return cell
    }
}
