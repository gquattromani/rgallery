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

struct Thumb: Equatable {
    let title: String
    let url: String
    let subreddit: String
}

extension Thumb: CustomStringConvertible {
    var description: String {
        return "\ntitle: \(title)\nurl: \(url)\nsubreddit: \(subreddit)\n"
    }
}

extension Thumb {
    // Verify if it is a valid thumb. Used NSDataDetector instead of UIApplication.shared.canOpenURL because if the user provided an input that doesn't include the http:// or https:// in the URL canOpenUrl will fail. NSDataDetector detect even URLs without the http:// scheme.
    var isValid: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self.url, options: [], range: NSRange(location: 0, length: self.url.utf16.count)) {
            return match.range.length == self.url.utf16.count
        } else {
            return false
        }
    }
}
