//
//  APIClient.swift
//  OhHellScoreKeepingApp
//
//  Created by Becca Kauper on 2/12/24.
//

import Foundation
import UIKit

enum APIClientError: Error {
    case noData
}

class APIClient {
    static let baseURL = "https://api.dicebear.com/7.x/identicon/png"
    static let cache = NSCache<NSString, UIImage>()
    
     class func urlString(for playerName: String, size: Int = 48) -> String {
        baseURL + "?seed=\(playerName)&size=\(size)"
    }
    
    // TODO: - Write the getIdenticonMethod to get the identicons via API
    
    class func getIdenticonFromAPI(playerName: String, completion: @escaping (UIImage?, Error?) -> Void) {
        let identiconEndpoint = APIClient.urlString(for: playerName)
        
        // if identicon is cached, then retrieve from storage
        if let image = cache.object(forKey: identiconEndpoint as NSString) {
            completion(image, nil)
            print("using cached image for: \(playerName)")
            return
        }
        
        // else fetch from api and add to storage
        let url = URL(string: identiconEndpoint)
        let urlRequest = URLRequest(url: url!)
        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error ?? APIClientError.noData)
                }
                return
            }
            DispatchQueue.main.async {
                let identicon = UIImage(data: data)
                cache.setObject(identicon!, forKey: identiconEndpoint as NSString)
                completion(identicon, nil)
            }
        })
        task.resume()
    }
    
    // TODO: Determine how images will be stored so they arent fetched every time (http cache? core data?)
    // Cache
    
    // TODO: Determine where the images will live in the code. How will the view controllers that need them access them? Dictionary? [playerName: seed] download image as file and store in project?
    
    // TODO: Remove spaces in names for images
}
