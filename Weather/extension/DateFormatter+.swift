//
//  DateFormatter+.swift
//  Weather
//
//  Created by dopamint on 7/15/24.
//

import Foundation

extension DateFormatter {
    
    static let formatter = DateFormatter()

    static func formatToHour(with date: String) -> String {
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let tempDate = formatter.date(from: date) else {
            print("날짜 변환 실패: \(date)")
            return "날짜 오류"
        }
        formatter.dateFormat = "H시"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "ko_KR")
        let resultDate = formatter.string(from: tempDate)
        return resultDate
    }
    
    static func formatToDateOnly(with date: String) -> String {
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let tempDate = formatter.date(from: date) else {
            print("날짜 변환 실패: \(date)")
            return "날짜 오류"
        }
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "ko_KR")
        let resultDate = formatter.string(from: tempDate)
        return resultDate
    }
    
    static func formatDateToString(with date: Date) -> String {
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "ko_KR")
        let resultDate = formatter.string(from: date)
        return resultDate
    }  
    static func formatDateToString(with date: String) -> Date {
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "ko_KR")
        let resultDate = formatter.date(from: date) ?? Date()
        return resultDate
    }
    
    static func formatToWeekday(with date: Date) -> String {
        formatter.dateFormat = "E"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "ko_KR")
        let resultDate = formatter.string(from: date)
        return resultDate
    }
}
