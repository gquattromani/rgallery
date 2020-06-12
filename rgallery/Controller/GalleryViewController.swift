//
//  ViewController.swift
//  rgallery
//
//  Created by gquatt on 10/06/2020.
//  Copyright © 2020 gquattromani. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var galleryManager = GalleryManager()
    
    private var searches: [Thumb] = []
    
    private let itemsPerRow: CGFloat = 3
    private let sectionInsets = UIEdgeInsets(top: 2.0, left: 1.0, bottom: 2.0, right: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        galleryManager.delegate = self
        
        setupCollectionView()
        setupSearchBar()
    }
    
    func setupCollectionView(){
        collectionView.dataSource = self
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = sectionInsets
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        let totalSpace = layout.minimumInteritemSpacing + layout.minimumLineSpacing + sectionInsets.left + sectionInsets.right
        
        layout.itemSize = CGSize(width: (self.collectionView.bounds.size.width - totalSpace)/itemsPerRow, height: (self.collectionView.bounds.size.width - totalSpace)/itemsPerRow)
        
        collectionView.collectionViewLayout = layout
    }
    
    func setupSearchBar(){
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        
        self.navigationItem.titleView = searchBar
    }
}

extension GalleryViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let textToSearch = searchBar.text {
            galleryManager.fetchGallery(keyword: textToSearch)
            self.collectionView?.reloadData()
        }
    }
}

extension GalleryViewController: GalleryManagerDelegate {
    func didUpdateData(_ galleryManager: GalleryManager, gallery: GalleryModel) {
        DispatchQueue.main.async { [weak self] in
            self?.searches = gallery.thumbs
            self?.collectionView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print("404: Not Found")
    }
    
}

extension GalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searches.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThumbCell", for: indexPath) as! PhotoCollectionViewCell
        let rThumb = searches[indexPath.row]
        cell.backgroundColor = .white
        cell.imageView.loadImageFromUrlString(urlString: rThumb.url)
          
        return cell
    }
}

