//
//  BabyListViewModel.swift
//  BabyStat
//
//  Created by KeithC on 2024-03-18.
//

import Foundation

class BabiesViewModel: ObservableObject {

    @Published var babies: [BabyListViewModel] = []
    @Published var isAdding: Bool = false
    
    let service: BabyServiceProtocol

    init(service: BabyServiceProtocol) {
        self.service = service
        fetchBabies()
    }
    
    func fetchBabies() {
        service.fetchBabies { result in
            switch result {
            case .success(let response):
                self.babies = response.map {
                    BabyListViewModel(name: $0.name, birth: $0.birth)
                }
            case .failure(let error):
                break
            }
        }
    }
}
