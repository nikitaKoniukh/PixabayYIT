//
//  SearchImagesListViewViewModel.swift
//  PixabayYIT
//
//  Created by Nikita Koniukh on 14/02/2023.
//

import UIKit

protocol SearchImagesListViewViewModelDelegate: AnyObject {
    func didLoadInitialHits()
    func didLoadMoreHits(with newIndexPaths: [IndexPath])
}

final class SearchImagesListViewViewModel: NSObject {
    
    private var cellViewModels: [ImageHitCollectionViewCellViewModel] = []
    public weak var delegate: SearchImagesListViewViewModelDelegate?
    private let cellHeight: Double = 90
    private var isLoadingMoreImages = false
    private let shouldShowLoader: Bool = true
    private let imagesPerPage = 20
    
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
    
    private var pageNumber: String {
        if hitsArray.count == 0 {
            return "1"
        }
        let nextPage = hitsArray.count / imagesPerPage + 1
        return "\(nextPage)"
    }
    
    public func fetchImages() {
        hitsArray = []
        let request = APIRequest(searchTerms: ["girls"], pageNumber: pageNumber)
        APIService.shared.execute(request, expecting: HitsResponse.self, completion: { [weak self] result in
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
    
    private func fetchAditionalImages() {
        guard !isLoadingMoreImages else {
            return
        }
        
        isLoadingMoreImages = true
        
        let request = APIRequest(searchTerms: ["girls"], pageNumber: pageNumber)
        APIService.shared.execute(request, expecting: HitsResponse.self, completion: { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            
            switch result {
            case .success(let hitsResponse):
                guard let moreResults = hitsResponse.hits else {
                    return
                }
                
                let originalCount = strongSelf.hitsArray.count
                let newCount = moreResults.count
                let totlal = originalCount + newCount
                let startingIndex = totlal - newCount
                let indexPathToAdd: [IndexPath] = Array(startingIndex..<(startingIndex + newCount)).map{ IndexPath(item: $0, section: 0) }
                strongSelf.hitsArray.append(contentsOf: moreResults)
                DispatchQueue.main.async {
                    strongSelf.delegate?.didLoadMoreHits(with: indexPathToAdd)
                    strongSelf.isLoadingMoreImages = false
                }
            case .failure:
                self?.isLoadingMoreImages = false
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,
              shouldShowLoader,
              let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FooterLoaderCollectionReusableView.footerId, for: indexPath) as? FooterLoaderCollectionReusableView else {
            fatalError()
        }
        footer.startAnimating()
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoader else {
            return .zero
        }
        return CGSize(width: collectionView.frame.width, height: 100)
    }
}

extension SearchImagesListViewViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoader,
              !isLoadingMoreImages,
              !cellViewModels.isEmpty else {
            return
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false, block: { [weak self] t in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height
            
            if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
                self?.fetchAditionalImages()
            }
            
            t.invalidate()
        })
    }
}
