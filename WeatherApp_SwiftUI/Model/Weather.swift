//
//  Weather.swift
//  WeatherApp_SwiftUI
//
//  Created by Guanglei Liu on 1/22/25.
//

import Foundation
import SwiftData

@Model
class Weather: Decodable {
    var location: Location
    var current: CurrentWeather

    init(location: Location, current: CurrentWeather) {
        self.location = location
        self.current = current
    }

    enum CodingKeys: String, CodingKey {
        case location
        case current
    } 

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.location = try container.decode(Location.self, forKey: .location)
        self.current = try container.decode(CurrentWeather.self, forKey: .current)
    }
}

extension Weather {
    var humidityDisplay: String {
        return "\(Int(current.humidity))%"
    }

    var uvDisplay: String {
        return "\(Int(current.uv))"
    }

    var temperatureDisplay: String {
        return "\(Int(current.tempF))\u{00B0}"
    }

    var feelsLikeDisplay: String {
        return "\(Int(current.feelsLikeF))\u{00B0}"
    }

    var locationDisplay : String {
        return location.name
    }

    var iconURL: URL? {
        return URL(string: "https:\(current.condition.iconURLString)")
    }
}
