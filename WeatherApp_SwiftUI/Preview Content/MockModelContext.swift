//
//  MockModelContext.swift
//  WeatherApp_SwiftUI
//
//  Created by Guanglei Liu on 1/26/25.
//

import Foundation
import SwiftData

extension ModelContext {
    @MainActor
    static let previewContainer: ModelContainer = {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)

            let container = try ModelContainer(for: Weather.self, configurations: config)

            let weather = Weather(
                location: Location(name: "Miami", country: "USA"),
                current: CurrentWeather(tempF: 10.0, humidity: 5.0, uv: 3.0, feelsLikeF: 2.0, condition: Condition(text: "Partly cloudy", iconURLString: "https://cdn.weatherapi.com/weather/64x64/night/116.png"))
            )

            container.mainContext.insert(weather)

            return container
        } catch {
            fatalError("Failed to create model container for previewing: \(error.localizedDescription)")
        }
    }()
}
