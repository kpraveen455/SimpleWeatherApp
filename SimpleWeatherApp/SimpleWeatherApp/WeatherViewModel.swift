//
//  WeatherViewModel.swift
//  SimpleWeatherApp
//
//  Created by praveen on 15/12/24.
//

import Foundation


class WeatherViewModel: ObservableObject {
    @Published var cityName: String = ""
    @Published var temperature: String = "--"
    @Published var isLoading: Bool = false
    
    private let apiKey = "YOUR_API_KEY"

    func fetchWeather(for city: String) {
        guard !city.isEmpty else { return }
        isLoading = true
        
        let cityQuery = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(cityQuery)&appid=\(apiKey)&units=metric"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
            }
            
            if let error = error {
                print("Error fetching weather: \(error)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.cityName = weatherResponse.name
                    self?.temperature = "\(weatherResponse.main.temp)°C"
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}
