//
//  SavedImagesListViewViewModel.swift
//  PixabayYIT
//
//  Created by Nikita Koniukh on 17/02/2023.
//

import UIKit

class SavedImagesListViewViewModel: NSObject {
    private var savedImages: [UIImage] {
        let images = FileManagerAPI.shared.loadImageFromDiskWith()
        return images
    }
    
}

extension SavedImagesListViewViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return savedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageHitCollectionViewCell.cellId, for: indexPath) as? ImageHitCollectionViewCell else {
            fatalError("No suported cell")
        }
        
        let image = savedImages[indexPath.item]
        cell.configure(with: image)
        cell.sizeToFit()
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        collectionView.deselectItem(at: indexPath, animated: true)
//        delegate?.didSelectImage(at: indexPath, hits: hitsArray)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: Double = (collectionView.frame.width - 16.0) / 2
        let height: Double = (collectionView.frame.width - 16.0) / 2
        return CGSize(width: width, height: height)
    }
}
