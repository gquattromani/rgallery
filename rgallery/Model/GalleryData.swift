//
//  GalleryData.swift
//  rgallery
//
//  Created by gquatt on 10/06/2020.
//  Copyright © 2020 gquattromani. All rights reserved.
//

import Foundation

struct GalleryData: Codable {
    let kind: String
    let data: DataGallery
}

struct DataGallery: Codable {
    let children: [Child]
}

struct Child: Codable {
    let kind: String
    let data: DataChild
}

struct DataChild: Codable {
    let title: String
    let subreddit: String
    let thumbnail: String
}
