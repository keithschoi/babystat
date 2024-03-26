//
//  AddBabyViewModel.swift
//  BabyStat
//
//  Created by KeithC on 2024-03-26.
//

import Foundation

class AddBabyViewModel: ObservableObject {
    
    var name: String = ""
    var birth: Date = Date()
    private var babyService: BabyServiceProtocol
    
    init(babyService: BabyServiceProtocol) {
        self.babyService = babyService
    }
    
    func addBaby(completion: @escaping (Bool) -> Void) {
        babyService.addBaby(name: name, birth: birth) { result in
            DispatchQueue.main.async {
                switch result {
                case .success():
                    completion(true)
                case .failure(let error):
                    // TODO:
                    completion(false)
                }
            }
        }
    }
}
