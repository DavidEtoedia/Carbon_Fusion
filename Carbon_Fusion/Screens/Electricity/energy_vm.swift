//
//  view_model.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 28/06/2023.
//

import Foundation


class EnergyViewModel : ObservableObject {
    private var repository : HttpRepository
    private var supaBaseRepo: SupaBaseRepository

    @Published var data: ResultState<DataModel, String> = .idle
    @Published var carbonVal : Double = 0.0
    @Published var hasError : Bool = false
    
    
    
    init() {
        let supaBaseRepo: SupaBaseRepository
        let repository: HttpRepository

        
        #if DEBUG
        if UITestingHelper.isUITesting {
            supaBaseRepo = MockSupaBaseRepository()
            repository = MockHttpRepositoryImp()
            
        } else {
            let supaBaseServiceRepo: SupaBaseRepository? = ServiceContainer.resolve(.singleton,SupaBaseRepository.self)
            supaBaseRepo = supaBaseServiceRepo!
            repository = HttpRepositoryImp()
        }
        #else
        let supaBaseServiceRepo: SupaBaseRepository? = ServiceContainer.resolve(.singleton,SupaBaseRepository.self)
        supaBaseRepo = supaBaseServiceRepo!
        repository = HttpRepositoryImp()
        #endif
        
        // Now, use the local variable to initialize your property
        self.supaBaseRepo = supaBaseRepo
        self.repository = repository

        self.getEnergy()
    }
  
    
    func calEnergy(value: Int, state: String) {
        self.data = .loading
    let req = ElectricityReq(type: "electricity", electricityUnit: "kwh", electricityValue: value, country: "us", state: state)
       // defer { self.result = .idle }
        if((value == .zero) || (state.isEmpty)){
            return
        } else{
            repository.createEnergy(session: .customSession, body: req) { result in
                switch result {
                case .success(let res):
                    self.data = .success(DataModel(carbonKg: res.datum?.attributes?.carbon_kg ?? 0.0, createdAt: res.datum?.attributes?.estimated_at ?? "", name: "Energy"))
                case .failure(let err):
                    print("printed \(err.localizedDescription)")
                    self.hasError = true
                    self.data = .failure(err.errorDescription ?? "")
            
                }
            }
        }

    }
    
    
    func getEnergy(){
        self.data = .loading
        Task{
            do {
                let result = try  await supaBaseRepo.getRequest(table: "Carbon")
                let res = result?.filter{$0.name == "Energy"}.last
                self.data = .success(res ?? DataModel(carbonKg: 0.0, createdAt: "", name: ""))
                hasError = false
            }
            catch{
                self.data = .idle
                hasError = true
                self.data = .failure(error.localizedDescription)
            }
        }
     
    }
    
    
    
    private func roundedValue() -> Decimal {
        return Decimal(ceil(carbonVal))
    }
}








enum ResultState<T, String> {
    case loading
    case idle
    case success(T)
    case failure(String)
  
    
    var value: T? {
        if case .success(let value) = self {
            return value
        }
        return nil
    }
    
    var error: String? {
        if case .failure(let error) = self {
            return error
        }
        return nil
    }
    var isLoading: Bool {
        if case .loading = self {
            return true
        }
        return false
    }
    
    var isIdle: Bool {
        if case .idle = self {
            return true
        }
        return false
    }
    
    var isSuccess: Bool {
        if case .success = self {
            return true
        }
        return false
    }
    
    var isFailure: Bool {
        if case .failure = self {
            return true
        }
        return false
    }
    
}
