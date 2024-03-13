//
//  ContentView.swift
//  BabyStat
//
//  Created by KeithC on 2023-06-22.
//

import SwiftUI
import CoreData

struct BabyList: View {
    
    // CoreData
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Baby.timestamp, ascending: false)],
        animation: .default)
    private var babies: FetchedResults<Baby>

    // State
    @State private var isAdding: Bool = false
    
    // View
    var body: some View {
        NavigationView {
            List {
                ForEach(babies) { baby in
                    NavigationLink {
                        BabyStat(baby: baby)
                    } label: {
                        Text("\(baby.name ?? "") (\(baby.birth?.string(displayStyle: .dateOnly) ?? ""))")
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                        .disabled(babies.isEmpty)
                }
                ToolbarItem {
                    Button(
                        action: { isAdding = true }
                    ) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .navigationTitle("Baby Stat")
        }.sheet(isPresented: $isAdding) {
            AddBaby(isPresented: $isAdding)
        }
    }

    // Private
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { babies[$0] }
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
