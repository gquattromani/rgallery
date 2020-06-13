//
//  DetailsViewCollectionViewCell.swift
//  rgallery
//
//  Created by gquatt on 13/06/2020.
//  Copyright © 2020 gquattromani. All rights reserved.
//

import UIKit

class DetailsViewCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(url: String){
        imageView.loadImageFromUrlString(urlString: url)
    }

}
