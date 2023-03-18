//
//  Date+Ext.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 17/03/2023.
//

import Foundation

extension DateFormatter {
    // Source: https://grokswift.com/nsdate-webservices/
    static var yearMonthDayDateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter
    }

    static var iso8601 = OptionalFractionalSecondsDateFormatter()
}
