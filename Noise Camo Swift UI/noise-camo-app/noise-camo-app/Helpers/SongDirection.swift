//
//  SongDirection.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 03/06/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import Foundation

enum SongDirection: CaseIterable {
    case backward, forward
    func getNewIndex(index: Int, count: Int) -> Int {
        switch self {
        case .backward:
            return (index == 0) ? (count-1) : (index-1)
        case .forward:
            return (index == (count-1)) ? 0 : index+1
        }
    }
    func getNewTimePosition(position: Double, change: Double, duration: Double) -> Double {
        switch self {
        case .backward:
            print(position-change)
            return ((position - change) < 0) ? 0 : (position - change)
        case .forward:
            return ((position + change) < duration) ? (position + change) : duration
        }
    }
    func getNewAdjustmentTime(current: Double, newPosition: Double, oldPosition: Double) -> Double {
        switch self {
        case .backward:
            return current - (oldPosition - newPosition)
        case .forward:
            return current + (newPosition - oldPosition)
        }
    }
}
