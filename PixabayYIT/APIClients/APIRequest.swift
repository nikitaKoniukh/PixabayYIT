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
        return URL(string: urlString)
    }
    
    init(searchTerms: [String]) {
        self.searchTerms = searchTerms
    }
}
