//
//  Date+String.swift
//  BabyStat
//
//  Created by KeithC on 2023-06-25.
//
import Foundation

extension Date {
    
    // Formatted duration string
    func timeAgo(_ unitsStyle: DateComponentsFormatter.UnitsStyle) -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = unitsStyle
        formatter.allowedUnits = [.year, .month, .day, .hour, .minute]
        formatter.zeroFormattingBehavior = .dropAll
        formatter.maximumUnitCount = 2
        
        return String(format: formatter.string(from: self, to: Date()) ?? "", locale: .current)
    }
}

extension Date {
    
    // Date and/or Time string
    func string(displayStyle: DisplayStyle) -> String {
        let formatter = DateFormatter()
        let styles = getStyleTuple(displayStyle)
        formatter.dateStyle = styles.date
        formatter.timeStyle = styles.time
        return formatter.string(from: self)
    }

    enum DisplayStyle {
        case dateOnly, dateOnlyShort, timeOnly, dateAndTime
    }

    private func getStyleTuple(_ displayStyle: DisplayStyle) -> (date: DateFormatter.Style, time: DateFormatter.Style) {
        switch displayStyle {
        case .dateOnly:
            return (.full, .none)
        case .dateOnlyShort:
            return (.short, .none)
        case .timeOnly:
            return (.none, .short)
        case .dateAndTime:
            return (.full, .short)
        }
    }
}

