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
    
    
    func getFormattedDate(for index: Int) -> String {
            guard let forecast = outputForecast.value,
                  index < forecast.list.count else {
                return ""
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            if let date = dateFormatter.date(from: forecast.list[index].dtTxt) {
                dateFormatter.dateFormat = "HH:mm"
                return dateFormatter.string(from: date)
            }
            return ""
        }
        
        func getWeatherIcon(for index: Int) -> String {
            guard let forecast = outputForecast.value,
                  index < forecast.list.count else {
                return "questionmark"
            }
            return forecast.list[index].weather.first?.icon ?? "questionmark"
        }
        
        func getTemperature(for index: Int) -> String {
            guard let forecast = outputForecast.value,
                  index < forecast.list.count else {
                return "N/A"
            }
            return "\(Int(forecast.list[index].main.temp))°"
        }
        
        func getDayOfWeek(for index: Int) -> String {
            guard let forecast = outputForecast.value,
                  index * 8 < forecast.list.count else {
                return ""
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            if let date = dateFormatter.date(from: forecast.list[index * 8].dtTxt) {
                dateFormatter.dateFormat = "EEEE"
                return dateFormatter.string(from: date)
            }
            return ""
        }
        
        func getMaxTemperature(for index: Int) -> String {
            guard let forecast = outputForecast.value,
                  index * 8 < forecast.list.count else {
                return "N/A"
            }
            return "최고 \(Int(forecast.list[index * 8].main.tempMax))°"
        }
        
        func getMinTemperature(for index: Int) -> String {
            guard let forecast = outputForecast.value,
                  index * 8 < forecast.list.count else {
                return "N/A"
            }
            return "최저 \(Int(forecast.list[index * 8].main.tempMin))°"
        }
}
