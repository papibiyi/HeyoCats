//
//  ImageCacheManager.swift
//  Mowee
//
//  Created by Mojisola Adebiyi on 25/05/2021.
//

import Foundation

/// Responsible for caching fetching and caching images by their URL strings
class ImageCacheManager {
    static let cache = NSCache<NSString, NSData>()
    static let session = URLSession(configuration: URLSessionConfiguration.default)
    static var taskDictionary: [String: URLSessionDataTask] = [:]

    static func fetchImageData(with uuid: String, from url: String, completion: @escaping (NSData) -> (Void)){
        DispatchQueue.global(qos: .background).async {
            let task = ImageCacheManager.taskDictionary[uuid]
            task?.cancel()
            let key = NSString(string: url)
            if let cachedVersion = ImageCacheManager.cache.object(forKey: key) {
                    completion(cachedVersion)
            } else {
                guard let url = URL(string: url) else {return}
                let task =  ImageCacheManager.session.dataTask(with: url) { data, _, _ in
                    guard let data = data else {return}
                    let ns = NSData(data: data)
                    ImageCacheManager.cache.setObject(ns, forKey: key)
                    completion(ns)
                }
                
                DispatchQueue.main.sync {
                    ImageCacheManager.taskDictionary.updateValue(task, forKey: uuid)
                }
                    
                task.resume()
            }
        }
    }
    
}
