//
//  PhotoCollectionViewCell.swift
//  rgallery
//
//  Created by gquatt on 12/06/2020.
//  Copyright © 2020 gquattromani. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func setupUI(){
        backgroundColor = .white
        contentView.layer.cornerRadius = 5.0
        contentView.layer.masksToBounds = true
    }
    
    func configureCell(url: String, text: String){
        imageView.loadImageFromUrlString(urlString: url)
        label.text = text
    }
    
}
