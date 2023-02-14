//
//  SearchImagesListViewViewModel.swift
//  PixabayYIT
//
//  Created by Nikita Koniukh on 14/02/2023.
//

import Foundation

class SearchImagesListViewViewModel: NSObject {
    
    public func fetchImages() {
        APIService.shared.execute(.init(searchTerms: ["yellow", "flowers"]), expecting: HitsResponse.self, completion: { result in
            switch result {
            case .success(let success):
                print(String(describing: success))
            case .failure(let failure):
                print(String(describing: failure))
            }
        })
    }
    
}
