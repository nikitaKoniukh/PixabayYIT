//
//  ImageDetailViewViewModel.swift
//  PixabayYIT
//
//  Created by Nikita Koniukh on 16/02/2023.
//

import UIKit

protocol ImageDetailViewViewModelDelegate: AnyObject {
    func mainImageFetched(with data: Data)
    func userImageFetched(with data: Data)
}

class ImageDetailViewViewModel: NSObject {
    
    weak var delegate: ImageDetailViewViewModelDelegate?
    private let hits: [Hits]
    private let selectedIndexPath: IndexPath
    private let selectedHit: Hits
    
    var tags: String {
        guard let tags = selectedHit.tags else {
            return ""
        }
        return "Tags: \(tags)"
    }
    
    var user: String {
        guard let user = selectedHit.user else {
            return ""
        }
        return user
    }
    
    var likes: String {
        guard let likes = selectedHit.likes else {
            return ""
        }
        return "Likes: \(likes)"
    }
    
    var imageHeight: Double {
        let bounds = UIScreen.main.bounds
        guard let originalWidth = selectedHit.imageWidth,
              let originalHeight = selectedHit.imageHeight else {
            return 0
        }
        
        let ratio = originalWidth / Int(bounds.width)
        let newHeight = originalHeight / ratio
        return Double(newHeight)
    }
    
    init(hits: [Hits], selectedIndexPath: IndexPath) {
        self.hits = hits
        self.selectedIndexPath = selectedIndexPath
        self.selectedHit = hits[selectedIndexPath.item]
        super.init()
        fetchMainImage()
        fetchUserImage()
    }
    
    func fetchMainImage() {
        ImageLoader.shared.loadImage(selectedHit.largeImageURL, complition: { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.delegate?.mainImageFetched(with: data)
                }
            case .failure:
                fatalError()
            }
        })
    }
    
    func fetchUserImage() {
        ImageLoader.shared.loadImage(selectedHit.userImageURL, complition: { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.delegate?.userImageFetched(with: data)
                }
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        })
    }
}
