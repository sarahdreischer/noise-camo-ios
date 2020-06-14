//
//  MusicError.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 13/06/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import Foundation

enum MusicError: Error {
    case parsing(description: String)
}
