//
//  Forecast.swift
//  Weather
//
//  Created by dopamint on 7/11/24.
//

import Foundation

struct Forecast: Decodable {
//    let cod: String
//    let message, cnt: Int
    let list: [List]
    let city: City
    
    struct List: Decodable {
//        let dt: Int // Time of data forecasted, unix, UTC
        let main: Main
        let weather: [Weather]
        let clouds: Clouds
        let wind: Wind
        let visibility: Int
        let pop: Double // 강수확률
        let sys: Sys
        let dtTxt: String

        enum CodingKeys: String, CodingKey {
            case main, weather, clouds, wind, visibility, pop, sys
            case dtTxt = "dt_txt"
        }
    }
    
    struct Main: Decodable {
        let temp, feelsLike, tempMin, tempMax: Double
        let pressure, seaLevel, grndLevel, humidity: Int
        let tempKf: Double

        enum CodingKeys: String, CodingKey {
            case temp
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case pressure
            case seaLevel = "sea_level"
            case grndLevel = "grnd_level"
            case humidity
            case tempKf = "temp_kf"
        }
    }
    
    struct Weather: Decodable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    
    struct Clouds: Decodable {
        let all: Int // Cloudiness, %
    }

    struct Wind: Decodable {
        let speed: Double
        let deg: Int
        let gust: Double
    }
    
    struct Coord: Decodable {
        let lon, lat: Double
    }
    
    struct City: Decodable {
        let id: Int
        let name: String
        let coord: Coord
        let country: String
        let population, timezone, sunrise, sunset: Int
    }

    struct Sys: Decodable { //  Part of the day (n - night, d - day)
        let pod: Pod
    }

    enum Pod: String, Decodable {
        case d = "d"
        case n = "n"
    }
}

