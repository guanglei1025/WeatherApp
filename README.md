# Weather App

Weather application built with **SwiftUI** and **SwiftData**. This app fetches real-time weather data from [WeatherAPI.com](https://www.weatherapi.com/docs/) and presents it in an intuitive and visually appealing UI.

## Features

- **Real-time Weather Data**: Fetch current weather conditions for any city.
- **MVVM Architecture**: Clean and modular codebase for easy maintainability.
- **SwiftData Integration**: Store and manage user preferences efficiently.
- **Error Handling**: Gracefully manage invalid city names and network failures.


## Screenshots

|Dashboard|Search Result|
|-|-|
|![Screenshot 2025-02-02 at 7 38 13 PM](https://github.com/user-attachments/assets/7fc4065a-d3b0-45be-93d6-d8b8e3cb6b7c)|![Screenshot 2025-02-02 at 7 38 20 PM](https://github.com/user-attachments/assets/29116302-d62d-4fac-bda7-4c795e806779)|



## Tech Stack

- **Swift** and **SwiftUI** for UI development.
- **SwiftData** for local data persistence.
- **WeatherAPI.com** for fetching weather data.
- **MVVM Architecture** for maintainable and scalable code.
- **Protocol-Oriented Programming** and **Dependency Injection** for better code reusability.



## API Integration

This app uses [WeatherAPI.com](https://www.weatherapi.com/docs/) to fetch weather data.

### Endpoints Used

- Current weather data: `/v1/current.json?key=YOUR_API_KEY&q=CITY_NAME`

