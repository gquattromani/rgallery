//
//  GalleryModel.swift
//  rgallery
//
//  Created by gquatt on 10/06/2020.
//  Copyright © 2020 gquattromani. All rights reserved.
//

import Foundation

struct GalleryModel {
    let thumbs: [Thumb]
}

struct Thumb {
    let title: String
    let url: String
    let subreddit: String
}

extension Thumb: CustomStringConvertible {
    var description: String{
        return "\ntitle: \(title)\nurl: \(url)\nsubreddit: \(subreddit)\n"
    }
}
