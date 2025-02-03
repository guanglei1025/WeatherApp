//
//  WeatherApp_SwiftUIApp.swift
//  WeatherApp_SwiftUI
//
//  Created by Guanglei Liu on 2/2/25.
//

import SwiftUI
import SwiftData

@main
struct WeatherApp_SwiftUIApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Weather.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            WeatherContainerView(modelContext: sharedModelContainer.mainContext)
                .modelContainer(sharedModelContainer)
        }
    }
}
