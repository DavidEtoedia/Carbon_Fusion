//
//  view_model.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 28/06/2023.
//

import Foundation


class EnergyViewModel : ObservableObject {
    @Published var result: ResultState<ElectricityResponse, String> = .idle
    @Service private var repository : HttpRepository
    @Published var carbonVal : Double = 0.0
    @Published var electricity = ElectricityResponse()
    @Published var hasError : Bool = false
    
    
    
    init() {
    }
    
    func calEnergy(value: Int, state: String) {
        self.result = .loading
    let req = ElectricityReq(type: "electricity", electricityUnit: "kwh", electricityValue: value, country: "uk", state: state)
       // defer { self.result = .idle }
        if((value == .zero) || (state.isEmpty)){
            return
        } else{
            repository.postCal(body: req) { result in
                switch result {
                case .success(let res):
                    self.electricity = res
                    self.result = .success(res)
                    print(res)
                case .failure(let err):
                    print("printed \(err.localizedDescription)")
                    self.hasError = true
                    self.result = .failure(err.errorDescription ?? "")
            
                }
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
