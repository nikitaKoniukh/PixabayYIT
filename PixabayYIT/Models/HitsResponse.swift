//
//  HitsResponse.swift
//  PixabayYIT
//
//  Created by Nikita Koniukh on 14/02/2023.
//

import Foundation

struct HitsResponse: Codable {
    var total: Int?
    var totalHits: Int?
    var hits: [Hits]?
}
