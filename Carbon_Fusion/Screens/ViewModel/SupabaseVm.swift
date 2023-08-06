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
    @Published var hasError : Bool = false
    @Published var carbonFTP : Double? = 0.0
    
    
    init() {
        
        if let storedCarbon = UserDefaults.standard.object(forKey: "Carbon") as? Double {
            carbonFTP = storedCarbon
        }
    //MARK: Get the response from supabase
        Task{
            await getTotal()
        }
    //MARK: Listen to when there is an insert event on the table
        getChannel()
    }
    

    
    func getTotal()async{
        do {
            let result = try  await supaBaseRepo.getRequest(table: "Carbon")
            
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
        user.subscribe()
        
    }
}
