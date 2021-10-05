//
//  Extension.swift
//  RxSwiftProject
//
//  Created by Nitin Gohel on 01/10/21.
//

import Foundation

extension String {
    func getDate() -> Date {
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        isoDateFormatter.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withFractionalSeconds]
        
        if let realDate = isoDateFormatter.date(from: self) {
            return realDate
        }
        return Date()
    }
}
