//
//  ViewRouter.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 30/05/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class ViewRouter: ObservableObject {

    let objectWillChange = PassthroughSubject<ViewRouter, Never>()

    @Published var currentView = "home" {
        didSet {
            objectWillChange.send(self)
        }
    }

}
