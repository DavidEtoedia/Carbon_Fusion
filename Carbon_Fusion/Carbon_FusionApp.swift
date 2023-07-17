//
//  Carbon_FusionApp.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 16/05/2023.
//

import SwiftUI

@main
struct Carbon_FusionApp: App {
    
    init(){
        setupServiceContainer()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(EnergyViewModel())
                
        }
    }
}


private extension Carbon_FusionApp {
    
    func setupServiceContainer() {
        // Services
        ServiceContainer.register(type: URLSession.self, .shared)
       // ServiceContainer.register(type: UserDefaults.self, .standard)
        ServiceContainer.register(type: NetworkManager.self, NetworkManagerImpl())
        
        // Repositories
        ServiceContainer.register(type: HttpRepository.self, HttpRepositoryImp())
    
    }
}
