//
//  Extensions.swift
//  rgallery
//
//  Created by gquatt on 12/06/2020.
//  Copyright © 2020 gquattromani. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadImageFromUrlString(urlString: String) {
        let url = URL(string: urlString)!
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

