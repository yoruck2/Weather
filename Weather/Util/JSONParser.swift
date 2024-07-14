//
//  JSONParser.swift
//  Weather
//
//  Created by dopamint on 7/15/24.
//

import Foundation

struct JSONParser {
    
    static func decode<T: Decodable>(_ data: Data, model: T.Type) -> T? {
        do {
            let decodedData = try JSONDecoder().decode(model, from: data)
            return decodedData
        } catch {
            return nil
        }
    }
}
