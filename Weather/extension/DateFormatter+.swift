//
//  DateFormatter+.swift
//  Weather
//
//  Created by dopamint on 7/15/24.
//

import Foundation
import Kingfisher

extension DateFormatter {
    
    static let formatter = DateFormatter()
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
//    static let formatToDate: DateFormatter = {
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        formatter.calendar = Calendar(identifier: .iso8601)
//        formatter.timeZone = TimeZone(secondsFromGMT: 0)
//        formatter.locale = Locale(identifier: "ko_KR")
//        print(formatter)
//        return formatter
//    }()
//    
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
    
    static let formatToWeekday: DateFormatter = {
        formatter.dateFormat = "E"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()
}
