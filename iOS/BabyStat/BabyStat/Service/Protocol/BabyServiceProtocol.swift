//
//  BabyPersistenceProtocol.swift
//  BabyStat
//
//  Created by KeithC on 2024-03-18.
//

import Foundation

protocol BabyServiceProtocol {

    func fetchBabies(completion: @escaping (Result<[Baby], Error>) -> Void)
    func addBaby(name: String, birth: Date, completion: @escaping (Result<Void, Error>) -> Void)
}
