//
//  GalleryManager.swift
//  rgallery
//
//  Created by gquatt on 10/06/2020.
//  Copyright © 2020 gquattromani. All rights reserved.
//

import Foundation

protocol GalleryManagerDelegate {
    func didUpdateData(_ galleryManager: GalleryManager, gallery: GalleryModel)
    func didFailWithError(error: Error)
}

struct GalleryManager {
    var delegate: GalleryManagerDelegate?
    
    func fetchGallery(keyword: String){
        let url = "https://www.reddit.com/r/\(keyword)/top.json"
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
            let decodedData = try decoder.decode(GalleryData.self, from: galleryData)
            let gallery = GalleryModel(thumbs: prepareData(for: decodedData))
            return gallery
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    func prepareData(for decodedData: GalleryData) -> [Thumb]{
        var res: [Thumb] = []
        let children = decodedData.data.children
        for child in children {
            res.append(Thumb(title: child.data.title, url: child.data.thumbnail, subreddit: child.data.subreddit))
        }
        return res
    }
    
}
