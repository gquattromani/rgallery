//
//  LocalizedStrings.swift
//  rgallery
//
//  Created by gquatt on 16/06/2020.
//  Copyright © 2020 gquattromani. All rights reserved.
//

import Foundation

private class LocalizableStringBundle: NSObject {
    static let bundle = Bundle(for: LocalizableStringBundle.self)
}

struct LocalizedStrings {
    static let search_bar_placeholder = NSLocalizedString("search_bar_placeholder", comment: "SearchBar Placeholder")
}
