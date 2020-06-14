//
//  MusicPublisherTests.swift
//  noise-camo-appTests
//
//  Created by Sarah Dreischer on 14/06/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import Foundation
import XCTest
@testable import noise_camo_app

class MusicPublisherTests: XCTestCase {
    func testPlayerViewmodel() {
       let musicFetcher = MusicFetcher()
        _ = musicFetcher.track(forSong: "song")
               .sink(receiveCompletion: { err in
                   print(".sink() received the completion", String(describing: err))
               }) { asset in
                   let playerViewModel = PlayerAssetViewModel(item: asset)
                   XCTAssertTrue( playerViewModel.title == "Impact Moderato")
           }
       }
}
