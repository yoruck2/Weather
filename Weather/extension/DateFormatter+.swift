//
//  DateFormatter+.swift
//  Weather
//
//  Created by dopamint on 7/15/24.
//

import Foundation
import Kingfisher

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
    static let formatToDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()
    
    static let formatToWeekday: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()
}
