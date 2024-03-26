//
//  AddBaby.swift
//  BabyStat
//
//  Created by KeithC on 2023-06-22.
//

import SwiftUI

struct AddBaby: View {
    @ObservedObject var viewModel: AddBabyViewModel
    @Binding var isPresented: Bool

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Name", text: $viewModel.name)
                    DatePicker("Birthday", selection: $viewModel.birth, displayedComponents: .date)
                }
                .navigationTitle("Add a baby")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem {
                        Button(action: {
                            viewModel.addBaby { success in
                                if success {
                                    isPresented = false
                                } else {
                                    // Handle failure, possibly with an error message or alert
                                }
                            }
                        }) {
                            Text("Add")
                        }
                        .disabled(viewModel.name.isEmpty)
                    }
                }
                Spacer()
            }
        }
    }
}
