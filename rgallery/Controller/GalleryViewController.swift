//
//  ViewController.swift
//  rgallery
//
//  Created by gquatt on 10/06/2020.
//  Copyright © 2020 gquattromani. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController, UISearchBarDelegate {
    
    var galleryManager = GalleryManager()
    
    private var searches: [Thumb] = []
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        galleryManager.delegate = self
        
        setupCollectionView()
        createSearchBar()
    }
    
    func setupCollectionView(){
        collectionView.dataSource = self
    }
    
    func createSearchBar(){
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        
        self.navigationItem.titleView = searchBar
    }
    
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
        print(error)
    }
    
}

extension GalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searches.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThumbCell", for: indexPath)
        cell.backgroundColor = .black
        // Configure the cell
        return cell
    }
    
    
}

