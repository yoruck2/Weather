//
//  String+.swift
//  Weather
//
//  Created by dopamint on 7/15/24.
//

import Foundation

extension String {
    var toDate: Date? {
        let birthdayFormatStyle = Date.FormatStyle()
            .year(.defaultDigits)
            .month(.twoDigits)
            .day(.twoDigits)
//            .weekday(.abbreviated)
            .locale(Locale(identifier: "ko_KR"))
        return try? birthdayFormatStyle.parse(self)
    }
}
