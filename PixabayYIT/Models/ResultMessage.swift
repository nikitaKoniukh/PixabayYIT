//
//  ResultMessage.swift
//  PixabayYIT
//
//  Created by Nikita Koniukh on 16/02/2023.
//

import Foundation

enum ResultMessage {
    case initial
    case error(errorText: String)
    case empty
    
    var text: String {
        switch self {
        case .initial:
            return "Welcome To Pixabay search App. Please enter key words to search."
        case .error(let errorText):
            return "Oops😱, thee rror occurred during search request: \(errorText)"
        case .empty:
            return "Nothing to show 😕"
        }
    }
}
