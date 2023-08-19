//
//  SupabaseVm.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 29/07/2023.
//

import Foundation

class SupbaseViewModel: ObservableObject {
    @Service  private var supaBaseRepo: SupaBaseRepository
    @Published var dataValue: DataModel = DataModel(carbonKg: 0.0, createdAt: "", name: "Carbon")
    @Published var result: ResultState<[DataModel], String> = .idle
    @Published var delete: ResultState<String?, String> = .idle
    @Published var hasError : Bool = false
    @Published var errorMsg : String = ""
    @Published var carbonFTP : Double = 0.0
    

    init() {
    //MARK: Get the response from supabase
        Task{
            await getTotal()
        }
//    //MARK: Listens to insert and delete event on the table
        getChannel()
    }
    
  
    
    func getTotal()async {
        do {
            let result = try  await supaBaseRepo.getRequest(table: "Carbon")
            self.result = .success(result ?? [])
            var sumByLastValue: [String: Double] = [:]

            for object in result! {
                sumByLastValue[object.name] = object.carbonKg
            }
            let sum = sumByLastValue.values.reduce(0, +)
            carbonFTP = sum
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
              try await supaBaseRepo.delete(id: id)
                self.delete = .success(nil)
            }
            catch {
                hasError = true
                self.result = .failure(error.localizedDescription)
            }
        }
      
    }
    
    
    func getChannel(){
        let user =  supaBaseRepo.realTime()
        user.on(.insert) { message in
            print(message.payload)
            
    //MARK: Make a request to get the updated values on the Table
            Task{
                await self.getTotal()
            }
        }
        user.on(.delete) { message in
            print(message.payload)
            //MARK: Make a request to get the updated values on the Table
            Task{
                await self.getTotal()
            }
        }
        user.subscribe()
        hasError = user.isErrored
    }
    
    func unsubscribe(){
        let user =  supaBaseRepo.realTime()
        user.unsubscribe()
    }
    

}
