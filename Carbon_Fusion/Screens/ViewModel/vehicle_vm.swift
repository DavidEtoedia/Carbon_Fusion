import Foundation


class VehicleViewModel : ObservableObject {
    @Published var result: ResultState<[VehicleResponse], String> = .idle
    @Service private var repository : HttpRepository
    @Published var hasError : Bool = false
    
    init(){
       // getVehicle()
    }
 
    func getVehicle() {
        self.result = .loading
        defer{self.result = .idle}
        repository.getVehicle { result in
            switch result {
            case .success(let res):
                self.result = .success(res)
                print(res)
            case .failure(let err):
                self.hasError = true
                self.result = .failure(err.localizedDescription)
            }
        }

    }
}

