//
//  APIService.swift
//  PixabayYIT
//
//  Created by Nikita Koniukh on 14/02/2023.
//

import Foundation

protocol APIServiceProtocol {
    func execute<T: Codable>(_ request: APIRequest, expecting type: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}

class APIService {
    static let shared = APIService()
    
    init(){}
    
    enum APIServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    public func execute<T: Codable>(_ request: APIRequest, expecting type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(APIServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? APIServiceError.failedToGetData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    private func request(from apiRequest: APIRequest?) -> URLRequest? {
        guard let url = apiRequest?.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = apiRequest?.httpMethod
        return request
    }
}
