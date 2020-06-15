//
//  Extensions.swift
//  rgallery
//
//  Created by gquatt on 12/06/2020.
//  Copyright © 2020 gquattromani. All rights reserved.
//

import UIKit

extension UICollectionView {
    func setEmptyMessage() {
        self.backgroundView = UINib(nibName: "EmptyView", bundle: .main).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
    
    func setNoResultsMessage() {
        self.backgroundView = UINib(nibName: "NoResultsView", bundle: .main).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
    
    func restoreBackground() {
        self.backgroundView = nil
    }
}
