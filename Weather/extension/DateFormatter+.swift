//
//  DateFormatter+.swift
//  Weather
//
//  Created by dopamint on 7/15/24.
//

import Foundation

extension DateFormatter {
//    static func formatDate(_ dateString: String) -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        guard let date = dateFormatter.date (from: dateString) else {
//            return ""
//        }
//        
//        dateFormatter.dateFormat = "HH:mm"
//        return dateFormatter.string(from: date)
//    }
//    
//    static func formatDayOfWeek(_ dateString: String) -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        guard let date = dateFormatter.date(from: dateString) else {
//            return ""
//        }
//        
//        dateFormatter.dateFormat = "E"
//        return dateFormatter.string(from: date)
//    }
//    
    static func getWeatherIcon(_ iconCode: String) -> String {
        switch iconCode {
        case "01d": 
            return "sun.max.fill"
        case "01n":
            return "moon.fill"
        case "02d":
            return "cloud.sun.fill"
        case "02n":
            return "cloud.moon.fill"
        case "03d", "03n", "04d", "04n":
            return "cloud.fill"
        case "09d", "09n":
            return "cloud.drizzle.fill"
        case "10d":
            return "cloud.sun.rain.fill"
        case "10n":
            return "cloud.moon.rain.fill"
        case "11d", "11n":
            return "cloud.bolt.rain.fill"
        case "13d", "13n":
            return "snow"
        case "50d", "50n":
            return "cloud.fog.fill"
        default:
            return "questionmark"
        }
    }
    
}
