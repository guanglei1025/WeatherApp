//
//  Item.swift
//  WeatherApp_SwiftUI
//
//  Created by Guanglei Liu on 2/2/25.
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
