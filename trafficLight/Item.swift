//
//  Item.swift
//  trafficLight
//
//  Created by LIDZIYA KAMYNINA  on 21/02/2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
