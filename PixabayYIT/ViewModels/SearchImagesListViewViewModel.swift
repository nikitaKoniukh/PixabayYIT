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
    private let cellHeight: Double = 70
    
    private var hitsArray: [Hits] = [] {
        didSet {
            for hit in hitsArray {
                guard let previewHeight = hit.previewHeight, let previewWidth = hit.previewWidth else {
                    return
                }
                
                let imageWidth = (cellHeight / Double(previewHeight)) * Double(previewWidth)
                let viewModel = ImageHitCollectionViewCellViewModel(previewURLString: hit.previewURL, imageWidth: imageWidth)
                
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

extension SearchImagesListViewViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageHitCollectionViewCell.cellId, for: indexPath) as? ImageHitCollectionViewCell else {
            fatalError("No suported cell")
        }
        
        let viewModel = cellViewModels[indexPath.item]
        cell.configure(with: viewModel)
        cell.sizeToFit()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = cellViewModels[indexPath.item]
        let width: Double = item.imageWidth ?? 0
        let height = cellHeight
        return CGSize(width: width, height: height)
    }
}

