//
//  ship_vm.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 27/07/2023.
//

import Foundation


class ShipViewModel: ObservableObject {
    @Service  private var supaBaseRepo: SupaBaseRepository
    @Published var data: ResultState<DataModel, String> = .idle
    @Published var result: ResultState<ShipResponseModel, String> = .idle
    @Service private var repository : HttpRepository
    @Published var hasError : Bool = false
    
    init(){
       getLogistics()
    }
    
    
    func createShip(weightValue:Int, weightUnit: String, distanceValue: Int, distanceUnit: String, transportMethod: String)
    {
        if( distanceValue == .zero || weightValue == .zero){
            return
        }
        self.result = .loading
        let ship = ShippingReq(type: "shipping", weightValue: weightValue, weightUnit: weightUnit, distanceValue: distanceValue, distanceUnit: distanceUnit, transportMethod: transportMethod)
        
        repository.createShipping(body: ship) { result in
            switch result {
            case .success(let res):
                self.result = .success(res)
                
                self.getLogistics()
                
                print(res)
                self.hasError = false
            case .failure(let err):
                self.hasError = true
                self.result = .failure(err.errorDescription ?? "")
            }
        }
    }
    
    func getLogistics(){
        self.data = .loading
        Task{
            
            do {
                let result = try  await supaBaseRepo.getRequest(table: "Carbon")
                let res = result?.filter{$0.name == "Logistics"}.last
                
                self.data = .success(res! )
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
