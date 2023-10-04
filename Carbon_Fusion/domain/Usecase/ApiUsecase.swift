//
//  ApiUsecase.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 03/10/2023.
//

import Foundation


class ApiUsecase {
    
    @Service private var apiRepository: ApiRepository
    @Service private var supabaseRepo: SupabaseRepository
    
    func createEnergy(req: ElectricityReq, completion: @escaping (Result<ElectricityResponse, ApiError>) -> Void) {
        apiRepository.createEnergy(body: req) { result in
            switch result {
            case .success(let res):
                let req = DataModel(carbonKg: (res.datum?.attributes?.carbon_kg)!, createdAt: (res.datum?.attributes?.estimated_at!)!, name: "Energy")
                Task {
                    await  self.supabaseRepo.saveCarbonFt(req: req, table: "Carbon")
                }
                completion(.success(res))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
    
    
    func createFlight(req: FlightReq, completion: @escaping (Result<FlightResponseModel, ApiError>) -> Void) {
        apiRepository.createFlight(body: req) { result in
            switch result {
            case .success(let res):
                let data = DataModel(carbonKg: (res.data?.attributes?.carbon_mt)!, createdAt: (res.data?.attributes?.estimated_at!)!, name: "Flight")
                Task {
                  await self.supabaseRepo.saveCarbonFt(req: data, table: "Carbon")
                }
                
                completion(.success(res))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
    
    
    func createShipping(req: ShippingReq, completion: @escaping (Result<ShipResponseModel, ApiError>) -> Void) {
        apiRepository.createShipping(body: req) { result in
            switch result {
            case .success(let res):
                let data = DataModel(carbonKg: (res.data?.attributes?.carbon_kg)!, createdAt: (res.data?.attributes?.estimated_at!)!, name: "Logistics")
                Task{
                    await self.supabaseRepo.saveCarbonFt(req: data, table: "Carbon")
                }
              
                completion(.success(res))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
    
    
}
