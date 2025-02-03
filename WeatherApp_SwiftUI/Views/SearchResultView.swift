//
//  SearchResultView.swift
//  WeatherApp_SwiftUI
//
//  Created by Guanglei Liu on 1/21/25.
//

import SwiftUI
import SwiftData

struct SearchResultView: View {

    @Environment(WeatherViewModel.self) private var viewModel

    var body: some View {
        if let searchedWeather = viewModel.searchedWeather {
            HStack{
                VStack(alignment: .leading, spacing: 10) {
                    Text(searchedWeather.locationDisplay)
                        .font(.system(size: 25, weight: .bold))

                    Text(searchedWeather.temperatureDisplay)
                        .font(.system(size: 60, weight: .semibold))
                }

                Spacer()

                AsyncImage(url: searchedWeather.iconURL) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 123, height: 123)
                } placeholder: {
                    ProgressView()
                }
            }
            .frame(maxWidth: .infinity)
            .padding(20)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10)
            .onTapGesture {
                viewModel.saveToLocalStorage(searchedWeather)
            }
        } else {
            EmptyView()
        }
    }
}

#Preview {
    let container = ModelContext.previewContainer
    var viewModel = WeatherViewModel(modelContext: container.mainContext)
    viewModel.searchKeyword = "New York"
    return SearchResultView()
        .environment(viewModel)
}
