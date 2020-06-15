//
//  UIImageView+Cache.swift
//  rgallery
//
//  Created by gquatt on 15/06/2020.
//  Copyright © 2020 gquattromani. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadImageFromUrlStringNoCache(urlString: String) {
        let url = URL(string: urlString)!
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async { [weak self] in
                        self?.image = image
                    }
                }
            }
        }
    }
    
    func loadImageFromUrlStringWithCache(urlString: String, cache: URLCache? = nil) {
        let url = URL(string: urlString)!
        let cache = cache ?? URLCache.shared
        let request = URLRequest(url: url)
        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            self.image = image
        } else {
            self.image = UIImage(named: "placeholder")
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                    let cachedData = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cachedData, for: request)
                    DispatchQueue.main.async { [weak self] in
                        self?.image = image
                    }
                }
            }).resume()
        }
    }
}
