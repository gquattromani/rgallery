//
//  ViewController.swift
//  rgallery
//
//  Created by gquatt on 10/06/2020.
//  Copyright © 2020 gquattromani. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {
    
    var galleryManager = GalleryManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        galleryManager.delegate = self
        galleryManager.fetchGallery(keyword: "house")
        
    }
}

extension GalleryViewController: GalleryManagerDelegate {
    func didUpdateData(_ galleryManager: GalleryManager, gallery: GalleryModel) {
        DispatchQueue.main.async {
            print(gallery.thumbs)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}

