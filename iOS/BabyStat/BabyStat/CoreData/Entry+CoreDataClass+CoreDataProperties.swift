//
//  Entry+CoreDataClass.swift
//
//
//  Created by KeithC on 2023-06-25.
//
//

import SwiftUI
import CoreData

// Entry+CoreDataClass.swift
@objc(Entry)
public class Entry: NSManagedObject {}

// Entry+CoreDataProperties.swift
extension Entry {
    @NSManaged public var type: String
    @NSManaged public var subtype: String
    @NSManaged public var value: NSNumber?
    @NSManaged public var timestamp: Date
    @NSManaged public var baby: Baby
}

extension Entry {
    static func createWith(
        type: String,
        subtype: String,
        timestamp: Date,
        value: Double,
        baby: Baby,
        using managedObjectContext: NSManagedObjectContext
    ) {
        let entry = Entry(context: managedObjectContext)
        entry.type = type
        entry.subtype = subtype
        entry.timestamp = timestamp
        entry.value = NSNumber(value: value)
        entry.baby = baby
        
        do {
            try managedObjectContext.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}

extension Entry {
    
    //Computed Var
    var lastDescription: String {
        switch type {
        case "sleeping", "awake":
            return "\(subtype) for \(timestamp.timeAgo(.brief))"
        default:
            return "Last \(type) \(timestamp.timeAgo(.brief)) ago"
        }
    }
    
    var unit: String {
        switch subtype {
        case "formula", "milk":
            return "ml"
        case "meal":
            return "portion"
        default:
            return ""
        }
    }
    
    var formattedValue: String {
        guard let value = value else { return "" }
        switch type {
        case "feeding":
            return "\(value.intValue) \(unit)"
        case "sleeping", "diaper", "hygiene":
            return timestamp.string(displayStyle: .timeOnly)
        default:
            return "\(value.intValue)"
        }
    }
}

extension Entry {
    
    //Array of Dates for Grouping
    static func getSections(_ result: FetchedResults<Entry>) -> [Date] {
        var dates: Set<Date> = []
        result.forEach { entry in
            let date = Calendar.current.startOfDay(for: entry.timestamp)
            if !dates.contains(date) {
                dates.insert(date)
            }
        }
        return Array(dates).sorted(by: >)
    }
}
