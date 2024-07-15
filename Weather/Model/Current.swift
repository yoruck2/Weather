//
//  Weather.swift
//  Weather
//
//  Created by dopamint on 7/11/24.
//

import Foundation

struct Current: Decodable {
    let coord: Coord
    let weather: [Weather]
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let timezone: Int
    let name: String
    //    let dt: Int // 시간
    //    let sys: Sys
    //    let base: String // internal parameter?
    //    let cod: Int // internal parameter?
    
    struct Weather: Decodable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    
    struct Coord: Decodable {
        let lon, lat: Double
    }

    struct Wind: Codable {
        let speed: Double
        let deg: Int
        let gust: Double?
    }

    struct Clouds: Decodable {
        let all: Int
    }

    struct Sys: Decodable {
        let country: String
        let sunrise: Int
        let sunset: Int
    }

    struct Main: Decodable {
        let temp: Double
        let feelsLike: Double
        let tempMin: Double
        let tempMax: Double
        let pressure, humidity: Int
        
        enum CodingKeys: String, CodingKey {
            case temp
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case pressure
            case humidity

        }
    }
}

