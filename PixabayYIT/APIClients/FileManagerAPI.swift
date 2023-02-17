//
//  FileManagerAPI.swift
//  PixabayYIT
//
//  Created by Nikita Koniukh on 17/02/2023.
//

import UIKit

class FileManagerAPI {
    static let shared = FileManagerAPI()
    
    func saveImage(imageName: String, imageData: Data) {
        
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        let fileName = imageName
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                print("Removed old image")
            } catch let removeError {
                print("couldn't remove file at path", removeError)
            }
        }
        
        do {
            try imageData.write(to: fileURL)
        } catch let error {
            print("error saving file with error", error)
        }
    }
    
    func loadImageFromDiskWith() -> [UIImage] {
        
        var images = [UIImage]()
        let fileManager = FileManager.default
        do {
            let documentsDirectoryURL = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let urls = try fileManager.contentsOfDirectory(at: documentsDirectoryURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            for url in urls {
                if let data = try? Data(contentsOf: url),
                   let image = UIImage(data: data) {
                    images.append(image)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        return images
    }
}
