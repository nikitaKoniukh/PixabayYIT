//
//  ImageLoader.swift
//  PixabayYIT
//
//  Created by Nikita Koniukh on 14/02/2023.
//

import Foundation

final class ImageLoader {
    static let shared = ImageLoader()
    private var imageDataCache = NSCache<NSString, NSData>()
    
    func loadImage(_ urlString: String?, complition: @escaping(Result<Data, Error>) -> Void) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            complition(.failure(URLError(.badURL)))
            return
        }
        let key = urlString as NSString
        
        if let data = imageDataCache.object(forKey: key) {
            complition(.success(data as Data))
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                complition(.failure(URLError(.badServerResponse)))
                return
            }
            
            let value = data as NSData
            
            self?.imageDataCache.setObject(value, forKey: key)
            complition(.success(data))
        }
        task.resume()
    }
}
