//
//  EntryType.swift
//  BabyStat
//
//  Created by KeithC on 2023-06-26.
//

enum EntryType: String, CaseIterable {
    case feeding, diaper, sleeping, hygiene
}

protocol EnterEntryEnum {
    var maxValue: Double { get }
    var unit: String { get }
    var step: Double { get }
}

extension EnterEntryEnum {
    var maxValue: Double { 1.0 }
    var unit: String { "count" }
    var step: Double { 1.0 }
}

enum FeedingType: String, EnterEntryEnum, CaseIterable  {
    case milk, formula, food
    var maxValue: Double {
        switch self {
        case .milk, .formula:
            return 300.0
        case .food:
            return 1.0
        }
    }
    var unit: String {
        switch self {
        case .milk, .formula:
            return "ml"
        case .food:
            return "portion"
        }
    }
    var step: Double {
        switch self {
        case .milk, .formula:
            return 10.0
        default:
            return 1.0
        }
    }
}

enum DiaperType: String, EnterEntryEnum, CaseIterable {
    case wet, bowel
}
enum HygieneType: String, EnterEntryEnum, CaseIterable {
    case shower, hip, teeth
}

enum SleepType: String, EnterEntryEnum, CaseIterable {
    case sleeping, awake
}
