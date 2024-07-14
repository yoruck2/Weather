//
//  City.swift
//  Weather
//
//  Created by dopamint on 7/15/24.
//

import Foundation

struct City: Decodable {
    let id: Int
    let name: String
    let state: String
    let country: String
    let coord: Coord
    
    struct Coord: Decodable {
        let lon, lat: Double
    }
}

