//
//  Location.swift
//  WeatherApp_SwiftUI
//
//  Created by Guanglei Liu on 1/26/25.
//

import Foundation
import SwiftData

@Model
class Location: Decodable {
    var name: String
    var country: String

    enum CodingKeys: String, CodingKey {
        case name
        case country
    }

    init (name: String, country: String) {
        self.name = name
        self.country = country
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.country = try container.decode(String.self, forKey: .country)
    }
}
