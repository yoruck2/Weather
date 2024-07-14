//
//  MainViewModel.swift
//  Weather
//
//  Created by dopamint on 7/15/24.
//


class MainViewModel {
    let outputCurrentWeather = Observable<Current?>(nil)
    let outputForecast = Observable<Forecast?>(nil)
    
    func fetchWeatherData(lat: Double, lon: Double) {
        NetworkService.shared.request(api: .current(lat: lat, lon: lon), model: Current.self) { [weak self] response, error in
            self?.outputCurrentWeather.value = response
        }
        
        NetworkService.shared.request(api: .forecast(lat: lat, lon: lon), model: Forecast.self) { [weak self] response, error in
            self?.outputForecast.value = response
        }
    }
}
