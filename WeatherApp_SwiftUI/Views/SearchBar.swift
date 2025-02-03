//
//  SearchBar.swift
//  WeatherApp_SwiftUI
//
//  Created by Guanglei Liu on 1/21/25.
//

import SwiftUI

struct SearchBar: View {

    @Binding var searchKeyword: String

    var body: some View {
        HStack {
            TextField("Search location", text: $searchKeyword)
                .padding()
                .foregroundStyle(.secondary)

            Image(systemName: "magnifyingglass")
                .frame(width: 17, height: 17)
                .padding(.trailing)
                .foregroundStyle(.secondary)
        }
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
    }
}

#Preview {
    SearchBar(searchKeyword: .constant("Search location"))
        .padding()
}
