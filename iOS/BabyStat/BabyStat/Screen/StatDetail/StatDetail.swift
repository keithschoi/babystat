//
//  ContentView.swift
//  BabyStat
//
//  Created by KeithC on 2023-06-22.
//

import SwiftUI
import CoreData

struct StatDetail: View {
    
    // Var
    private var type: EntryType
    private var baby: Baby
    
    // CoreData
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest var entries: FetchedResults<Entry>
    
    // State
    @State private var isUpdating: Bool = false
    
    // Init
    init(type: EntryType, baby: Baby) {
        self.type = type
        self.baby = baby
        _entries = FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \Entry.timestamp, ascending: false)],
            predicate: NSPredicate(format: "baby == %@ && type == %@", baby, type.rawValue)
        )
    }
    
    // View
    var body: some View {
        NavigationView {
            List {
                ForEach(Entry.getSections(entries), id: \.self) { date in
                    Section(date.string(displayStyle: .dateOnlyShort)) {
                        let filtered = entries.filter {
                            Calendar.current.startOfDay(for: $0.timestamp) == date
                        }
                        ForEach(filtered, id: \.self) { entry in
                            HStack {
                                Text(entry.subtype)
                                Spacer()
                                Text(entry.formattedValue)
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                        .disabled(entries.isEmpty)
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle(type.rawValue.capitalized)
        }.sheet(isPresented: $isUpdating) {
            EnterEntry(mode: .update, baby: baby, isPresented: $isUpdating)
        }
    }
    
    // Methods
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { entries[$0] }
                .forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                let error = error as NSError
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
