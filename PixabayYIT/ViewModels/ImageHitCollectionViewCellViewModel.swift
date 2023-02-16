//
//  ImageHitCollectionViewCellViewModel.swift
//  PixabayYIT
//
//  Created by Nikita Koniukh on 14/02/2023.
//

import Foundation

class ImageHitCollectionViewCellViewModel: Hashable, Equatable {
   
    static func == (lhs: ImageHitCollectionViewCellViewModel, rhs: ImageHitCollectionViewCellViewModel) -> Bool {
        return lhs.previewURLString == rhs.previewURLString
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(previewURLString)
    }
    
    public let previewURLString: String?
    public let imageWidth: Double?
    
    init(previewURLString: String?, imageWidth: Double?) {
        self.previewURLString = previewURLString
        self.imageWidth = imageWidth
    }
}
