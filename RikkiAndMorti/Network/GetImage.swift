//
//  GetImage.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 28.06.2023.
//

import UIKit

final class GetImage {

    private var imageCache = NSCache<NSString, UIImage>()
    
    func downloadImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
        } else {
            let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10)
            let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
                guard error == nil,
                      let data = data,
                      let response = response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    return
                }
                guard let image = UIImage(data: data) else { return }
                self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                
                DispatchQueue.main.async {
                    completion(image)
                }
            }
            dataTask.resume()
        }
    }
    
    func clearCache() {
        imageCache.removeAllObjects()
    }
}
