//
//  LocalStorageService.swift
//  WeatherApp_SwiftUI
//
//  Created by Guanglei Liu on 1/23/25.
//

import Foundation
import SwiftData
import os

@MainActor
class LocalStorageService {

    let viewModelLog = OSLog(subsystem: "com.WeatherApp", category: "LocalStorageService")

    private var modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    func addWeather(_ weather: Weather) {
        modelContext.insert(weather)
    }

    func updateWeather(with newWeather: Weather) {
        if let storedWeather = getWeather() {
            storedWeather.location = newWeather.location
            storedWeather.current = newWeather.current
        } else {
            addWeather(newWeather)
        }
        saveModelContext()
    }

    func getWeather() -> Weather? {
        let fetchRequest = FetchDescriptor<Weather>()
        do {
            return try modelContext.fetch(fetchRequest).first
        } catch {
            return nil
        }
    }

    private func saveModelContext(){
        do {
            try modelContext.save()
        } catch {
            os_log("Failed to save in model context", log: viewModelLog, type: .debug)
        }
    }
}
