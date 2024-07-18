//
//  MainViewModel.swift
//  Weather
//
//  Created by dopamint on 7/15/24.
//

import Foundation

final class MainViewModel {
    let inputReloadTrigger = Observable<Void>(())
    let outputCurrentWeather = Observable<Current?>(nil)
    let outputForecast = Observable<Forecast?>(nil)
    let outputThreeHoursForecast = Observable<[Forecast.List]>([])
    let outputFiveDaysForecast = Observable<[DailyForecast]>([])
    
    func fetchWeatherData(lat: Double, lon: Double) {
        NetworkService.shared.request(api: .current(lat: lat, lon: lon), model: Current.self) { [weak self] response in
            switch response {
            case .success(let data):
                self?.inputReloadTrigger.value = ()
                self?.outputCurrentWeather.value = data
            case .failure(let error):
                print(error)
            }
        }
        NetworkService.shared.request(api: .forecast(lat: lat, lon: lon), model: Forecast.self) { [weak self] response in
            switch response {
            case .success(let data):
                self?.inputReloadTrigger.value = ()
                self?.outputForecast.value = data
                self?.setUpThreeHoursForecast()
                self?.setUpFiveDaysForecast()
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    private func setUpThreeHoursForecast() {
        guard let forecastList = outputForecast.value?.list else {
            return
        }
        
        let currentDate = Date()
        let filteredForecast = forecastList.filter { forecastItem in
//            guard let forecastDate = DateFormatter.formatToDate.date(from: forecastItem.dtTxt) else {
//                return false
//            }
//            return forecastDate >= currentDate
            return true
        }
        
        let threeDaysForecast = Array(filteredForecast.prefix(24))
        outputThreeHoursForecast.value = threeDaysForecast
    }
    
//    private func setUpFiveDaysForecast() {
//        guard let forecastList = outputForecast.value?.list else {
//            return
//        }
//        
//        forecastList.map { weather in
//            
//            weather.main.
//        }
//    }
//    
    
    
    
    private func setUpFiveDaysForecast() {
        guard let forecastList = outputForecast.value?.list else {
            return
        }
        let groupedForecasts = Dictionary(grouping: forecastList) { forecast -> Date in
//            let date = DateFormatter.formatToDate.date(from: forecast.dtTxt) ?? Date()
            let date = Date()
            return Calendar.current.startOfDay(for: date)
        }

        let sortedDays = groupedForecasts.keys.sorted()

        let dailyForecasts = sortedDays.prefix(5).enumerated().map { (index, date) -> DailyForecast in
            let dayForecasts = groupedForecasts[date] ?? []
            let maxTemp = dayForecasts.map { $0.main.tempMax }.max() ?? 0
            let minTemp = dayForecasts.map { $0.main.tempMin }.min() ?? 0
            let mostCommonWeather = dayForecasts.map { $0.weather.first }.compactMap { $0 }.mostCommon

            return DailyForecast(date: date,
                                 isToday: index == 0,
                                 maxTemp: maxTemp,
                                 minTemp: minTemp,
                                 weatherIcon: mostCommonWeather?.icon ?? "")
        }

        outputFiveDaysForecast.value = dailyForecasts
        print(outputFiveDaysForecast.value)
    }
}

struct DailyForecast {
    let date: Date
    let isToday: Bool
    let maxTemp: Double
    let minTemp: Double
    let weatherIcon: String
}

extension Sequence where Element: Hashable {
    var mostCommon: Element? {
        return self.grouped().max { $0.1.count < $1.1.count }?.key
    }
    
    func grouped() -> [Element: [Element]] {
        return Dictionary(grouping: self) { $0 }
    }
}
