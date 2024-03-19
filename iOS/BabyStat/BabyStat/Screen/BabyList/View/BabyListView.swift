//
//  BabyListView.swift
//  BabyStat
//
//  Created by KeithC on 2024-03-19.
//

import SwiftUI

struct BabyListViewModel: Identifiable {

    var id = UUID()
    let name: String
    let birth: Date
}

struct BabyList: View {
    
    @Binding var babies: [BabyListViewModel]
    
    var body: some View {
        List {
            ForEach(babies) { baby in
                NavigationLink {
//                    BabyStat(baby: baby)
                } label: {
                    Text("\(baby.name) (\(baby.birth.string(displayStyle: .dateOnly)))")
                }
            }
//            .onDelete(perform: deleteItems)
        }
    }
}
