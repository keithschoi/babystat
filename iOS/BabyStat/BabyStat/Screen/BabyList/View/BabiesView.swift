//
//  ContentView.swift
//  BabyStat
//
//  Created by KeithC on 2023-06-22.
//

import SwiftUI
import CoreData

struct BabiesView: View {
    
    @ObservedObject private var viewModel: BabiesViewModel
    
    init(viewModel: BabiesViewModel) {
        self.viewModel = viewModel
    }

    // View
    var body: some View {
        NavigationView {
            BabyList(babies: $viewModel.babies)
            .navigationTitle("Babies.BabyStat")
        }.sheet(isPresented: $viewModel.isAdding) {
            AddBaby(isPresented: $viewModel.isAdding)
        }
    }
}
