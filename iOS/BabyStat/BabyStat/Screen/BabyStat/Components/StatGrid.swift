//
//  StatGrid.swift
//  BabyStat
//
//  Created by KeithC on 2023-06-23.
//

import SwiftUI

struct StatGrid: View {
    
    // CoreData
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest var result: FetchedResults<CDEntry>
    private var last: CDEntry? {
        result.isEmpty ? nil : result[0]
    }
    
    // Var
    private let type: EntryType
    private let baby: CDBaby
    
    // Init
    init(type: EntryType, baby: CDBaby) {
        self.type = type
        self.baby = baby
        _result = FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \CDEntry.timestamp, ascending: false)],
            predicate: NSPredicate(format: "baby == %@ && type == %@", baby, type.rawValue)
        )
    }
    
    // View 
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(
                LinearGradient(
                    gradient: .init(
                        colors: AnyIterator { } .prefix(2).map {
                            .random(opacity: 0.85)
                        }
                    ),
                    startPoint: .topLeading, endPoint: .bottomTrailing
                )
            )
            .frame(height: 200)
            .overlay(
                Text(type.rawValue.capitalized)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(10)
                    .frame(alignment: .topLeading),
                alignment: .topLeading
            )
            .overlay(
                Text(last?.lastDescription ?? "No last record")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(10)
                    .frame(alignment: .bottomTrailing),
                alignment: .bottomTrailing
            )
    }
}
