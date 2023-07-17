import Foundation


class VehicleViewModel : ObservableObject {
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

