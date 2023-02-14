//
//  Hits.swift
//  PixabayYIT
//
//  Created by Nikita Koniukh on 14/02/2023.
//

import Foundation

struct Hits: Codable {
    var id: Int?
    var pageURL: String?
    var type: String?
    var tags: String?
    var previewURL: String?
    var previewWidth: Int?
    var previewHeight: Int?
    var webformatURL: String?
    var webformatWidth: Int?
    var webformatHeight: Int?
    var largeImageURL: String?
    var imageWidth: Int?
    var imageHeight: Int?
    var imageSize: Int?
    var views: Int?
    var downloads: Int?
    var collections: Int?
    var likes: Int?
    var comments: Int?
    var user_id: Int?
    var user: String?
    var userImageURL: String?
}
