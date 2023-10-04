//
//  ship_vm.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 27/07/2023.
//

import Foundation


class ShipViewModel: ObservableObject {
    @Service  private var supaBaseUsecase: SupaBaseUsecase
    @Service private var repository : ApiUsecase
    @Published var data: ResultState<DataModel, String> = .idle
   
    @Published var hasError : Bool = false
    
    init(){
       getLogistics()
    }
    
    
    func createShip(weightValue:Int, weightUnit: String, distanceValue: Int, distanceUnit: String, transportMethod: String)
    {
        if( distanceValue == .zero || weightValue == .zero){
            return
        }
        self.data = .loading
        let ship = ShippingReq(type: "shipping", weightValue: weightValue, weightUnit: weightUnit, distanceValue: distanceValue, distanceUnit: distanceUnit, transportMethod: transportMethod)
        
        repository.createShipping(req: ship) { result in
            switch result {
            case .success(let res):
                self.data = .success(DataModel(carbonKg: res.data?.attributes?.carbon_kg ?? 0.0, createdAt: res.data?.attributes?.estimated_at ?? "", name: "Logistics"))
                self.hasError = false
            case .failure(let err):
                self.hasError = true
                self.data = .failure(err.errorDescription ?? "")
            }
        }
    }
    
    func getLogistics(){
        self.data = .loading
        Task{
            
            do {
                let result = try  await supaBaseUsecase.getAll()
                let res = result?.filter{$0.name == "Logistics"}.last
                self.data = .success(res ?? DataModel(carbonKg: 0, createdAt: "", name: ""))
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
