//
//  PlayerViewModel.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 14/06/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import Foundation
import AVFoundation

struct MusicAssetViewModel: Identifiable, Hashable {
    private let item: AVURLAsset
    
    var id: String {
        return title + artist
    }
    
    var artwork: Data {
        return item.commonMetadata.filter { $0.commonKey?.rawValue == "artwork" }.map { $0.value as! Data}.first ?? Data.init(count: 0)
    }
    
    var title: String {
        return item.commonMetadata.filter { $0.commonKey?.rawValue == "title" }.map { $0.value as! String }.first ?? ""
    }
    
    var artist: String {
        return item.commonMetadata.filter { $0.commonKey?.rawValue == "artist" }.map { $0.value as! String }.first ?? ""
    }

    init(item: AVURLAsset) {
        self.item = item
    }
}
