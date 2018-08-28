//
//  DateExtension.swift
//  ArcTouch
//
//  Created by Victor de Paula Fernandes Pereira on 27/08/2018.
//  Copyright © 2018 Victor de Paula Fernandes Pereira. All rights reserved.
//

import Foundation
import UIKit


extension  Date {
    public func dateToString() -> String {
        let calendar = Calendar.current
        
        let day = calendar.component(.day, from: self)
        let month = calendar.component(.month, from: self)
        let year = calendar.component(.year, from: self)
        
        if day < 10 && month < 10{
            return "0"+String(day)+"/0"+String(month)+"/"+String(year)
        }
        if month < 10 {
            return String(day)+"/0"+String(month)+"/"+String(year)
        } else {
            return String(day)+"/"+String(month)+"/"+String(year)
        }
    }

    func new(from string: String, format: String) -> Date? {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT-3:00")
        return dateFormatter.date(from: string)
    }
}
