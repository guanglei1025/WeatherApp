//
//  WeatherViewModel.swift
//  WeatherApp_SwiftUI
//
//  Created by Guanglei Liu on 1/21/25.
//

import Foundation
import Observation
import SwiftUI
import SwiftData

@Observable
@MainActor
class WeatherViewModel {

    var searchKeyword: String = "" {
        didSet {
            if searchKeyword.count > 3 {
                Task {
                    await getWeatherForSearchedLocation(searchKeyword)
                }
            }
        }
    }

    var searchedWeather: Weather?

    private var weatherService: WeatherAPIFetching

    private var localStorageService: LocalStorageService

    init(modelContext: ModelContext, weatherService: WeatherAPIFetching = WeatherAPIService()) {
        self.localStorageService = LocalStorageService(modelContext: modelContext)
        self.weatherService = weatherService
    }

    var showSearchResult: Bool {
        return searchKeyword.count > 3 && searchedWeather != nil
    }

    func getWeatherForSavedLocation() async {
        guard let storedLocation = localStorageService.getWeather()?.location else {
            return
        }
        do {
            let weather = try await weatherService.getCurrentWeather(for: storedLocation.name)
            localStorageService.updateWeather(with: weather)
        } catch {
            print("Handle Error")
        }
    }

    func getWeatherForSearchedLocation(_ location: String) async {
        do {
            searchedWeather = try await weatherService.getCurrentWeather(for: location)
        } catch {
            print("Handle Error")
        }
    }

    func saveToLocalStorage(_ weather: Weather) {
        localStorageService.updateWeather(with: weather)
        // Reset screen after tap to save
        searchKeyword = ""
    }
}
