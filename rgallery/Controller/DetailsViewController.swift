//
//  DetailsViewController.swift
//  rgallery
//
//  Created by gquatt on 13/06/2020.
//  Copyright © 2020 gquattromani. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var thumb: Thumb!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(thumb!)
        setupViews()
       
    }
    
    func setupViews(){
//        collectionView.dataSource = self
        
        title = thumb.subreddit
        label.text = thumb.title
        imageView.loadImageFromUrlString(urlString: self.thumb.url)
    }
}
//
//extension DetailsViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//    }
//
//
//}
