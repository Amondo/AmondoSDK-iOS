//
//  Date+Util.swift
//  Amondo
//
//  Created by developer@amondo.com on 5/25/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation

extension Date {
    func stringEvent(showYear: Bool) -> String! {
        let calendar = Calendar.current
        let day = calendar.component(.day, from: self)
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        let dayOrdinal = formatter.string(from: NSNumber(value: day))
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = showYear ? "MMM yyyy" : "MMM"
        let month = dateFormatter.string(from: self)
        
        return dayOrdinal! + " " + month
    }

    func stringAnalytics() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat="yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter.string(from: self)
    }
    
    static func yesterday(date: Date) -> Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: Date.noon(date: date))!
    }
    static func tomorrow(date: Date) -> Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: Date.noon(date: date))!
    }
    static func noon(date: Date) -> Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: date)!
    }
}


