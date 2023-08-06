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
    @Published var result: ResultState<FlightResponseModel, String> = .idle
    @Service private var repository : HttpRepository
    @Published var hasError : Bool = false
    
    
    init(){
        getFlights()
    }
    
    
    func createFlight(passengers: Int, legs: Array<LegReq>){
        if(passengers == .zero || legs.isEmpty){
            return
        }
        self.result = .loading
        let flight = FlightReq(type: "flight", passengers: 2, legs: legs)
        
        repository.createFlight(body: flight) { result in
            switch result {
            case .success(let res):
                print(res)
                self.result = .success(res)
                self.getFlights()
                self.hasError = false
            case .failure(let err):
                print(err.errorDescription ?? "")
                self.hasError = true
                self.result = .failure(err.errorDescription ?? "")
                
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
