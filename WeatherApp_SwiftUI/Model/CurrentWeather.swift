//
//  CurrentWeather.swift
//  WeatherApp_SwiftUI
//
//  Created by Guanglei Liu on 1/26/25.
//

import Foundation
import SwiftData

@Model
class CurrentWeather: Decodable {
    var tempF: Double
    var humidity: Double
    var uv: Double
    var feelsLikeF: Double
    var condition: Condition

    enum CodingKeys: String, CodingKey {
        case tempF = "temp_f"
        case humidity
        case uv
        case feelsLikeF = "feelslike_f"
        case condition
    }

    init(tempF: Double, humidity: Double, uv: Double, feelsLikeF: Double, condition: Condition) {
        self.tempF = tempF
        self.humidity = humidity
        self.uv = uv
        self.feelsLikeF = feelsLikeF
        self.condition = condition
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.tempF = try container.decode(Double.self, forKey: .tempF)
        self.humidity = try container.decode(Double.self, forKey: .humidity)
        self.uv = try container.decode(Double.self, forKey: .uv)
        self.feelsLikeF = try container.decode(Double.self, forKey: .feelsLikeF)
        self.condition = try container.decode(Condition.self, forKey: .condition)
    }
}

@Model
class Condition: Decodable {
    var text: String
    var iconURLString: String

    enum CodingKeys: String, CodingKey {
        case text
        case iconURLString = "icon"
    }

    init(text: String, iconURLString: String) {
        self.text = text
        self.iconURLString = iconURLString
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.text = try container.decode(String.self, forKey: .text)
        self.iconURLString = try container.decode(String.self, forKey: .iconURLString)
    }
}
