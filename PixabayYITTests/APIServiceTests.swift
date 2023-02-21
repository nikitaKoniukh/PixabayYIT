//
//  APIServiceTests.swift
//  PixabayYITTests
//
//  Created by Nikita Koniukh on 21/02/2023.
//

import XCTest
@testable import PixabayYIT

final class APIServiceTests: XCTestCase {
    
    var sut: APIService!
    
    func testSut() {

        let didRecieveResponse = expectation(description: #function)
        sut = APIService()
        var result: Result<HitsResponse, Error>?
    
        let request = APIRequest(searchTerms: ["flower"], pageNumber: "1", perPage: "20")
        
        sut.execute(request, expecting: HitsResponse.self) { r in
            result = r
            didRecieveResponse.fulfill()
            
        }
        
        wait(for: [didRecieveResponse], timeout: 2)
        
        switch result {
        case .success(let hits):
            XCTAssertTrue(hits.hits?.count == 20)
            XCTAssertEqual(request.url, URL(string: "https://pixabay.com/api/?key=10668448-46e05cd2a47186d1f9231b721&q=flower&page=1&per_page=20"))
        case .failure:
            break
        case .none:
            break
        }
                    
    }

}
