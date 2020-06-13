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
    var others: [Thumb]!
    
    private let dim: CGFloat = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
       
    }
    
    func setupViews(){
        title = thumb.subreddit
        label.text = thumb.title
        imageView.loadImageFromUrlString(urlString: self.thumb.url)
        setupCollectionView()
    }
    
    func setupCollectionView(){
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "DetailsViewCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "DetailsViewCollectionViewCell")
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        layout.scrollDirection = .horizontal
        let totalSpace = layout.minimumInteritemSpacing + layout.minimumLineSpacing
        layout.itemSize = CGSize(width: (collectionView.bounds.size.width - totalSpace)/dim, height: (collectionView.bounds.size.width - totalSpace)/dim)
        collectionView.collectionViewLayout = layout
    }
    
    func centerItemsInCollectionView(cellWidth: Double, numberOfItems: Double, spaceBetweenCell: Double, collectionView: UICollectionView) -> UIEdgeInsets {
        let totalWidth = cellWidth * numberOfItems
        let totalSpacingWidth = spaceBetweenCell * (numberOfItems - 1)
        let leftInset = (collectionView.frame.width - CGFloat(totalWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
}

extension DetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return others.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsViewCollectionViewCell", for: indexPath) as! DetailsViewCollectionViewCell
        cell.configureCell(url: others[indexPath.row].url)
        return cell
    }
}
