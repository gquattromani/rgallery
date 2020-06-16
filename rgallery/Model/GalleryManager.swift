//
//  GalleryManager.swift
//  rgallery
//
//  Created by gquatt on 10/06/2020.
//  Copyright © 2020 gquattromani. All rights reserved.
//

import Foundation

protocol GalleryManagerProtocol {
    func fetchGallery(keyword: String) -> Void
}

protocol GalleryManagerDelegate {
    func didUpdateData(_ galleryManager: GalleryManager, gallery: GalleryModel)
    func didFailWithError(error: Error)
}

struct GalleryManager: GalleryManagerProtocol {
    var delegate: GalleryManagerDelegate?
    
    func fetchGallery(keyword: String){
        let url = "https://www.reddit.com/r/\(keyword.lowercased())/top.json"
        performRequest(with: url)
    }
    
    func performRequest(with url: String) {
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url){ (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let gallery = self.parseJSON(safeData){
                        self.delegate?.didUpdateData(self, gallery: gallery)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ galleryData: Data) -> GalleryModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(GalleryDataRoot.self, from: galleryData)
            let gallery = GalleryModel(thumbs: prepareData(for: decodedData))
            return gallery
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    func prepareData(for decodedData: GalleryDataRoot) -> [Thumb]{
        var res: [Thumb] = []
        let children = decodedData.data.children
        for child in children {
            let thumb = Thumb(title: child.data.title, url: child.data.thumbnail, subreddit: child.data.subreddit)
            if thumb.isValid {
                res.append(thumb)
            }
        }
        return res
    }
    
}
