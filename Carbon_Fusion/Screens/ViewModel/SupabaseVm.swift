//
//  SupabaseVm.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 29/07/2023.
//

import Foundation

class SupbaseViewModel: ObservableObject {
   @Service private var supabaseUsecase : SupaBaseUsecase
    
    @Published var dataValue: DataModel = DataModel(carbonKg: 0.0, createdAt: "", name: "Carbon")
    @Published var flight: DataModel?
    @Published var energy: DataModel?
    @Published var logistics: DataModel?
    @Published var result: ResultState<[DataModel], String> = .idle
    @Published var delete: ResultState<String?, String> = .idle
    @Published var hasError : Bool = false
    @Published var isDelete : Bool = false
    @Published var errorMsg : String = ""
    @Published var carbonFTP : Double = 0.0
    

    

    init() {
//        let supabaseUsecase: SupaBaseUsecaseRepository // Declare a local variable
//
//
//
//        #if DEBUG
//        if UITestingHelper.isUITesting {
//            supabaseUsecase = MockSupaBaseUsecase()
//        } else {
//            supabaseUsecase = ServiceContainer.resolve(.singleton, SupaBaseUsecase.self)!
//        }
//        #else
//        supaBaseRepo = SupaBaseUsecase()
//        #endif
//
//        // Now, use the local variable to initialize your property
//        self.supabaseUsecase = supabaseUsecase

        // The rest of your code here
        Task {
            await self.getTotal()
        }
        getChannel()
    }

    
  
    
    func getTotal()async {
        self.result = .loading
        do {
            let result = try await supabaseUsecase.getAll()
           
            let totalCarbonKg = result?.reduce(0) { $0 + $1.carbonKg }
            carbonFTP = totalCarbonKg ?? 0
          
            logistics = result?.filter{$0.name == "Logistics"}.first
            flight = result?.filter{$0.name == "Flight"}.first
            energy = result?.filter{$0.name == "Energy"}.first
           
            self.result = .success(result ?? [])
            hasError = false
            
        }
        catch{
            hasError = true
            self.result = .failure(error.localizedDescription)
        }
    }
    
    
    func delete(id: String)  {
        self.delete = .loading
        Task {
            do{
              try await supabaseUsecase.delete(id: id)
                self.delete = .success("Success")
            }
            catch {
                hasError = true
                self.result = .failure(error.localizedDescription)
            }
        }
      
    }
    
    
    func getChannel(){
   
        let user =  supabaseUsecase.realtime()
        user.on(.insert) { message in
            print(message.payload)

    //MARK: Make a request to get the updated values on the Table
            Task{
                await self.getTotal()
            }
        }
        user.on(.delete) { message in
            print(message.payload)
            Task{
                await self.getTotal()
            }
        }
        user.subscribe()
        hasError = user.isErrored
    }
    
    func unsubscribe(){
        let user =  supabaseUsecase.realtime()
        user.unsubscribe()
    }
    

}
