//
//  CalendarDateFormatter.swift
//  Airbnb-iOS
//
//  Created by 지희의 MAC on 2023/11/21.
//

import Foundation

class CalendarDateFormatter {
    private let calendar = Calendar.current
    private let dateFormatter = DateFormatter()
    private var nowCalendarDate = Date()
    private(set) var days = [String]()
    
    init() {
        self.configureCalendar()
    }
    
    func getYearMonthText() -> String {
        let yearMonthText = self.dateFormatter.string(from: self.nowCalendarDate)
        return yearMonthText
    }
    
    func updateCurrentMonthDays() {
        self.days.removeAll()
        
        let startDayOfWeek = self.getStartingDayOfWeek()
        let totalDaysOfMonth = startDayOfWeek + self.getEndDateOfMonth()
        
        for day in 0..<totalDaysOfMonth {
            if day < startDayOfWeek {
                self.days.append("")
            } else {
                self.days.append("\(day - startDayOfWeek + 1)")
            }
        }
    }
    
    func getUnableDate() -> Int {
        let nowformatter = DateFormatter()
        nowformatter.dateStyle = .long
        nowformatter.dateFormat = "dd"
        let nowDay = nowformatter.string(from: Date())
        guard let nowDay = Int(nowDay) else { return 0 }
        return nowDay + getStartingDayOfWeek() - 1
    }
    
}

extension CalendarDateFormatter {
    func getStartingDayOfWeek() -> Int {
        return self.calendar.component(.weekday, from: self.nowCalendarDate) - 1
    }
    
    func getEndDateOfMonth() -> Int {
        return self.calendar.range(of: .day, in: .month, for: self.nowCalendarDate)?.count ?? 0
    }
    
    func configureCalendar() {
        let components = self.calendar.dateComponents([.year, .month], from: Date())
        self.nowCalendarDate = self.calendar.date(from: components) ?? Date()
        self.dateFormatter.dateFormat = "yyyy년 MM월"
    }
}
