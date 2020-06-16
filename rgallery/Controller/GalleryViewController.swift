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
    
    private let dim: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 2.0, left: 1.0, bottom: 2.0, right: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        galleryManager.delegate = self
        
        setupCollectionView()
        setupSearchBar()
    }
    
    func setupCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.setEmptyMessage()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = sectionInsets
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        let totalSpace = layout.minimumInteritemSpacing + layout.minimumLineSpacing + sectionInsets.left + sectionInsets.right
        layout.itemSize = CGSize(width: (collectionView.bounds.size.width - totalSpace)/dim, height: (collectionView.bounds.size.width - totalSpace)/dim)
        
        collectionView.collectionViewLayout = layout
    }
    
    func setupSearchBar(){
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = false
        searchBar.placeholder = LocalizedStrings.search_bar_placeholder
        searchBar.delegate = self
        searchBar.accessibilityIdentifier = K.searchBarAccessibilityIdentifier
        
        navigationItem.titleView = searchBar
    }
}

extension GalleryViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        if let textToSearch = searchBar.text {
            galleryManager.fetchGallery(keyword: textToSearch)
            collectionView.reloadData()
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            collectionView.setEmptyMessage()
            clearAll()
        }
    }
}

extension GalleryViewController: GalleryManagerDelegate {
    func didUpdateData(_ galleryManager: GalleryManager, gallery: GalleryModel) {
        DispatchQueue.main.async { [weak self] in
            self?.searches = gallery.thumbs
            self?.searches.count == 0 ? self?.collectionView.setNoResultsMessage() : self?.collectionView.restoreBackground()
            self?.collectionView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.clearAll()
            self?.collectionView.setNoResultsMessage()
        }
    }
    
}

extension GalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searches.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.thumbCellIdentifier, for: indexPath) as! PhotoCollectionViewCell
        let rThumb = searches[indexPath.row]
        cell.configureCell(url: rThumb.url, text: rThumb.subreddit)
        return cell
    }
    
    func clearAll(){
        searches.removeAll()
        collectionView.reloadData()
    }
}

extension GalleryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destination = storyboard?.instantiateViewController(identifier: K.detailsViewControllerIdentifier) as? DetailsViewController
        destination?.thumb = searches[indexPath.row]
        destination?.others = searches.enumerated().filter{ index, element in
            return index != indexPath.row
        }
        .map{ index, element in
            return element
        }
        navigationController?.pushViewController(destination!, animated: true)
    }
}

