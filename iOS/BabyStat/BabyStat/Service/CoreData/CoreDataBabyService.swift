//
//  CoreDataBabyService.swift
//  BabyStat
//
//  Created by KeithC on 2024-03-18.
//

import Foundation
import CoreData

final class CoreDataBabyService: BabyServiceProtocol {
    
    private var viewContext: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.viewContext = context
    }
}

extension CoreDataBabyService {

    func fetchBabies(completion: @escaping (Result<[Baby], Error>) -> Void) {
        
        let request: NSFetchRequest<CDBaby> = CDBaby.fetchRequest()
        let sortDescriptors = [NSSortDescriptor(keyPath: \CDBaby.timestamp, ascending: false)]
        request.sortDescriptors = sortDescriptors
        do {
            let fetchResult = try viewContext.fetch(request)
            let babies = convertToBabies(fetchResult)
            completion(.success(babies))
        } catch {
            completion(.failure(error))
        }
    }
    
    func convertToBabies(_ cdbabies: [CDBaby]) -> [Baby] {
        cdbabies.compactMap {
            Baby(
                name: $0.name,
                birth: $0.birth,
                timestamp: $0.timestamp)
        }
    }
}
