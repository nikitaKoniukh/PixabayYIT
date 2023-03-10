//
//  APIRequest.swift
//  PixabayYIT
//
//  Created by Nikita Koniukh on 14/02/2023.
//

import Foundation

final class APIRequest {
    
    private struct Constants {
        static let baseUrl = "https://pixabay.com/api/"
        static let apiKey = "10668448-46e05cd2a47186d1f9231b721"
    }
    
    private let searchTerms: [String]
    private let pageNumber: String
    private let perPage: String
    public let httpMethod = "GET"
    
    public var urlString: String {
        var string = Constants.baseUrl
        string += "?key="
        string += Constants.apiKey
        string += "&q="
        
        if !searchTerms.isEmpty {
            string += searchTerms.joined(separator: "+")
        }
        
        return string
    }
    
    public var url: URL? {
        let page = "&page=" + pageNumber
        let perPage = "&per_page=" + perPage
        let urlString = urlString + page + perPage
        return URL(string: urlString)
    }
    
    init(searchTerms: [String], pageNumber: String, perPage: String) {
        self.searchTerms = searchTerms
        self.pageNumber = pageNumber
        self.perPage = perPage
    }
}
