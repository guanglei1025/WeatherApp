//
//  WeatherAPIService.swift
//  WeatherApp_SwiftUI
//
//  Created by Guanglei Liu on 1/21/25.
//

import Foundation
import SwiftData

protocol WeatherAPIFetching {
    func getCurrentWeather(for keyword: String) async throws -> Weather
}

enum WeatherAPIError: LocalizedError {
    case invalidURL
    case badResponse(statusCode: Int)
    case decodingError

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided was invalid. Please check the input and try again."
        case .badResponse(let statusCode):
            return "The server returned an unexpected response with status code \(statusCode)."
        case .decodingError:
            return "There was an error decoding the weather data. Please try again later."
        }
    }
}

class WeatherAPIService: WeatherAPIFetching {

    private let session: URLSessionProtocol

    private let key = "ad6c1da48de14e28bb935230252201"

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    func getCurrentWeather(for keyword: String) async throws -> Weather {
        let urlString = "https://api.weatherapi.com/v1/current.json?key=\(key)&q=\(keyword)"
        guard let url = URL(string: urlString) else {
            throw WeatherAPIError.invalidURL
        }

        let (data, response) = try await session.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode
        else {
            throw WeatherAPIError.badResponse(statusCode: (response as? HTTPURLResponse)?.statusCode ?? 0)
        }

        do {
            return try JSONDecoder().decode(Weather.self, from: data)
        } catch {
            throw WeatherAPIError.decodingError
        }
    }
}

public protocol URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol { }
