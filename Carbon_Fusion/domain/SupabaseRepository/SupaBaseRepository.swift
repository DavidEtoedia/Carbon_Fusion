//
//  SupaBaseRepository.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 02/10/2023.
//

import Foundation
import Realtime

protocol SupabaseRepository {
    func saveCarbonFt(req: DataModel, table: String) async -> Void
    func delete(id: String) async throws -> Void
    func getRequest(table: String) async throws -> [DataModel]?
    func realTime() -> Realtime.Channel
}

extension SupabaseRepository {
    func saveCarbonFt(req: DataModel, table: String) async -> Void { }
    func delete(id: String) async throws -> Void { }
    func getRequest(table: String) async throws -> [DataModel]? { return nil }
    func realTime() -> Realtime.Channel { fatalError("This is testing phase") }
}
