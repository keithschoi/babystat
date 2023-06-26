//
//  AddBaby.swift
//  BabyStat
//
//  Created by KeithC on 2023-06-22.
//

import SwiftUI

struct AddBaby: View {
    
    // CoreData
    @Environment(\.managedObjectContext) private var viewContext
    
    // State, Binding var
    @State private var name: String = ""
    @State private var birth: Date = Date()
    @Binding var isPresented: Bool
    
    // View
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField(text: $name, label: {
                        Text("Name")
                    })
                    DatePicker("Birthday", selection: $birth, displayedComponents: .date
                    )
                }
                .navigationTitle("Add a baby")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem {
                        Button(action: addBaby) {
                            Text("Add")
                        }
                        .disabled(name.isEmpty)
                    }
                }
                Spacer()
            }
        }
    }
    
    // Private method
    private func addBaby() {
        let baby = Baby(context: viewContext)
        baby.name = name
        baby.birth = birth
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
        isPresented = false
    }
}
