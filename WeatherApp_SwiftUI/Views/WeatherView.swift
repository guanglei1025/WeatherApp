//
//  WeatherView.swift
//  WeatherApp_SwiftUI
//
//  Created by Guanglei Liu on 1/21/25.
//

import SwiftUI
import SwiftData

struct WeatherView: View {
    @Environment(WeatherViewModel.self) var viewModel

    @Query
    var weathers: [Weather]

    var body: some View {
        Group {
            if let weather = weathers.first {
                bodyContent(for: weather)
            } else {
                noContent
            }
        }
        .task {
            if weathers.first != nil {
                await viewModel.getWeatherForSavedLocation()
            }
        }
    }

    @ViewBuilder
    private func bodyContent(for weather: Weather) -> some View {
        VStack(spacing: 20) {
            AsyncImage(url: weather.iconURL) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 123, height: 123)
            } placeholder: {
                ProgressView()
            }

            HStack(alignment: .center) {
                Text(weather.locationDisplay)
                    .font(.system(size: 35, weight: .bold))

                Image(systemName: "location.fill")
                    .imageScale(.large)
            }

            Text(weather.temperatureDisplay)
                .font(.system(size: 100, weight: .semibold))

            HStack(spacing: 50) {
                VerticalCell(title: "Humidity", subtitle: weather.humidityDisplay)
                VerticalCell(title: "UV", subtitle: weather.uvDisplay)
                VerticalCell(title: "Feels Like", subtitle: weather.feelsLikeDisplay)
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10)
        }
    }

    @ViewBuilder
    private var noContent: some View {
        VStack(spacing: 20) {
            Text("No City Selected")
                .font(.system(size: 35, weight: .bold))

            Text("Please Search For A City")
                .font(.system(size: 20, weight: .bold))
        }
        .padding(.top, 150)
    }
}

struct VerticalCell : View {
    let title: String
    let subtitle: String

    var body: some View {
        VStack(spacing: 10) {
            Text(title)
                .foregroundStyle(.secondary)

            Text(subtitle)
                .foregroundStyle(.secondary)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    let container = ModelContext.previewContainer
    WeatherView()
        .environment(WeatherViewModel(modelContext: container.mainContext))
}
