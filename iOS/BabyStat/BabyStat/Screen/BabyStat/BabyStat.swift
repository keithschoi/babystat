//
//  BabyStat.swift
//  BabyStat
//
//  Created by KeithC on 2023-06-23.
//

import SwiftUI

struct BabyStat: View {
    
    // Var
    private var baby: CDBaby
    @State private var isEnteringStat: Bool = false
    
    // Init
    init(baby: CDBaby) {
        self.baby = baby
    }
    
    // View
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                Text("Hey \(baby.name ?? "")")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text(baby.birth?.timeAgo(.full) ?? "")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer(minLength: 50.0)
                LazyVGrid(columns: [
                    .init(.flexible(minimum:150)),
                    .init(.flexible(minimum:150))]
                ) {
                    ForEach(EntryType.allCases, id: \.self) { entryType in
                        NavigationLink {
                            StatDetail(type: entryType, baby: baby)
                        } label: {
                            StatGrid(type: entryType, baby: baby)
                        }
                    }
                }
            }
            .padding()
            .toolbar {
                ToolbarItem {
                    Button(
                        action: { isEnteringStat = true }
                    ) {
                        Label("", systemImage: "plus")
                    }
                }
            }.sheet(isPresented: $isEnteringStat) {
                EnterEntry(mode: .add, baby: baby, isPresented: $isEnteringStat)
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        )
        .navigationBarTitleDisplayMode(.inline)
    }
}
