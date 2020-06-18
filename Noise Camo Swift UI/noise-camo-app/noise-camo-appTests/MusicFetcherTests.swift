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

class MusicFetcherTests: XCTestCase {
    
    private var musicFetcher: MusicFetchable = MusicFetcher()
    
    override func setUpWithError() throws {
        
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAssetTitleCanBeFetched() {
        //       let musicFetcher = MusicFetcher()
        _ = musicFetcher.track(forSong: "song")
            .sink(receiveCompletion: { err in
                print(".sink() received the completion", String(describing: err))
            }) { asset in
                let assetViewModel = MusicAssetViewModel(item: asset)
                XCTAssertTrue( assetViewModel.title == "Impact Moderato")
        }
    }
    
    func testAssetArtworkIsEmpty() {
        
    }
}
