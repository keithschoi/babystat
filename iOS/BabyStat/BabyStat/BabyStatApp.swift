//
//  BabyStatApp.swift
//  BabyStat
//
//  Created by KeithC on 2023-06-22.
//

import SwiftUI

@main
struct BabyStatApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            BabiesView(
                viewModel: BabiesViewModel(
                    service: CoreDataBabyService(
                        context: PersistenceController.shared.container.viewContext
                    )
                )
            )
        }
    }
}
