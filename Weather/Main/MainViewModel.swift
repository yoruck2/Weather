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
        let threeDaysForecast = Array(forecastList.prefix(24))
        outputThreeHoursForecast.value = threeDaysForecast
    }
    
    private func setUpFiveDaysForecast() {
        guard let forecastList = outputForecast.value?.list else {
            return
        }
        
        //
        let calendar = Calendar.current
        print(calendar)
        // forecastList를 date 를 키값으로 그룹화 한다 -> 일별로 최저,최고온도를 모으기 위한 과정
        // [날짜 : [Forecast.List]]
        let groupedForecasts = Dictionary(grouping: forecastList) { forecast -> String in
            return DateFormatter.formatToDateOnly(with: forecast.dtTxt)
        }
        
        // 순서가 없기 때문에 키값으로 정렬
        let sortedDays = groupedForecasts.keys.sorted()
        
        // 5일간의 데이터를 앞에서 자른 뒤 (prefix) 하나씩 뽑아서..
        let dailyForecasts = sortedDays.prefix(5).map { dateString -> DailyForecast in
            
            let date = DateFormatter.formatDateToString(with: dateString)
            
            // groupedForecasts 에서 dateString을 키값으로 딕셔너리에 접근, 일별 Forecast를 뽑아낸다
            let dayForecasts = groupedForecasts[dateString] ?? []
            
            // 최대, 최소 온도를 각각 모아서 그중 최대값, 최소값 구하기
            let maxTemp = dayForecasts.map { $0.main.tempMax }.max() ?? 0
            let minTemp = dayForecasts.map { $0.main.tempMin }.min() ?? 0
            
            // 가장 많이 등장한 weather
            let mostCommonWeather = dayForecasts.map { $0.weather.first }.compactMap { $0 }.mostCommon
            return DailyForecast(date: date,
                                 isToday: calendar.isDateInToday(date),
                                 maxTemp: maxTemp,
                                 minTemp: minTemp,
                                 //가장 많이 등장한 weahter의 icon
                                 weatherIcon: mostCommonWeather?.icon ?? "")
        }
        outputFiveDaysForecast.value = dailyForecasts
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
    //
    var mostCommon: Element? {
        // 가장 요소(count)가 많은 배열의 키(.Key) 리턴
        // ex) [1: [1, 1], 2: [2, 2, 2], 3: [3]] -> 2
        return self.grouped().max { $0.1.count < $1.1.count }?.key
    }
    
    // $0 : 각 요소를 키값으로 그룹화 한다.
    // ex) [1, 2, 2, 3, 2, 1] -> [1: [1, 1], 2: [2, 2, 2], 3: [3]]
    func grouped() -> [Element: [Element]] {
        return Dictionary(grouping: self) { $0 }
    }
}
