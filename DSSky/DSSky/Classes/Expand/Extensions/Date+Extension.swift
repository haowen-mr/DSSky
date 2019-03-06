//
//  Date+Extension.swift
//  DSSky
//
//  Created by 左得胜 on 2019/3/6.
//  Copyright © 2019 左得胜. All rights reserved.
//

import Foundation

extension Date {
    public static func from(string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+8:00")
        return dateFormatter.date(from: string)!
    }
}
