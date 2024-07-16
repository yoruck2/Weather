//
//  Forecast.swift
//  Weather
//
//  Created by dopamint on 7/11/24.
//

import Foundation

struct Forecast: Decodable {
    let list: [List]
    
    struct List: Decodable {
//        let dt: Int // Time of data forecasted, unix, UTC
        let main: Main
        let weather: [Weather]
        let clouds: Clouds
        let wind: Wind
        let dtTxt: String

        enum CodingKeys: String, CodingKey {
            case main, weather, clouds, wind
            case dtTxt = "dt_txt"
        }
    }
    
    struct Main: Decodable {
        let temp, tempMin, tempMax: Double
        let pressure, humidity: Int

        enum CodingKeys: String, CodingKey {
            case temp
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case pressure
            case humidity
        }
    }
    struct Weather: Decodable, Hashable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    
    struct Clouds: Decodable {
        let all: Int
    }

    struct Wind: Decodable {
        let speed: Double
        let deg: Int
        let gust: Double
    }
    struct Coord: Decodable {
        let lon, lat: Double
    }
}

