//
//  view-model.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 25/07/2023.
//

import Foundation

class FlightViewModel: ObservableObject {
    @Service  private var supaBaseRepo: SupaBaseRepository
    @Published var data: ResultState<DataModel, String> = .idle
    @Service private var repository : HttpRepository
    @Published var hasError : Bool = false
    
    
    init(){
        getFlights()
    }
    
    
    func createFlight(passengers: Int, legs: Array<LegReq>){
        if(passengers == .zero || legs.isEmpty){
            return
        }
        self.data = .loading
        let flight = FlightReq(type: "flight", passengers: 2, legs: legs)
        
        repository.createFlight(session: .customSession, body: flight) { result in
            switch result {
            case .success(let res):
                self.data = .success(DataModel(carbonKg: res.data?.attributes?.carbon_mt ?? 0.0, createdAt: res.data?.attributes?.estimated_at ?? "", name: "Flight"))
                self.hasError = false
            case .failure(let err):
                self.hasError = true
                self.data = .failure(err.errorDescription ?? "")
                
            }
        }
    }
    
    func getFlights(){
        self.data = .loading
        Task{
            
            do {
                let result = try  await supaBaseRepo.getRequest(table: "Carbon")
                let res = result?.filter{$0.name == "Flight"}.last
                self.data = .success(res ?? DataModel(carbonKg: 0.0, createdAt: "", name: "") )
                hasError = false
            }
            catch{
                self.data = .idle
                hasError = true
                self.data = .failure(error.localizedDescription)
            }
        }
    }
    
    
}
