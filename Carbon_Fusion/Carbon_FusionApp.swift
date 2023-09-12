//
//  Carbon_FusionApp.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 16/05/2023.
//

import SwiftUI

@main
struct Carbon_FusionApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    init(){
        setupServiceContainer()
    }
    var body: some Scene {
        WindowGroup {
            MainRoute()
                .environmentObject(EnergyViewModel())
                .environmentObject(ShipViewModel())
                .environmentObject(FlightViewModel())
                .environmentObject(SupbaseViewModel())
                
        }
    }
}


private extension Carbon_FusionApp {
    
    func setupServiceContainer() {
        // Services
        ServiceContainer.register(type: URLSession.self, .shared)
       // ServiceContainer.register(type: UserDefaults.self, .standard)
       
        
#if DEBUG
        if UITestingHelper.isUITesting{
            ServiceContainer.register(type: NetworkServiceManager.self, MockNetworkService())
            ServiceContainer.register(type: MockSupaBaseManagerProtocol.self, MockSupaBaseMangerImpl())
            ServiceContainer.register(type: SupaBaseRepository.self, MockSupaBaseRepository())
            
        }
        else{
            ServiceContainer.register(type: NetworkServiceManager.self, NetworkService())
            ServiceContainer.register(type: SupaBaseManager.self, SupaBaseService.shared)
            ServiceContainer.register(type: SupaBaseRepository.self, SupaBaseRepoImpl())
            ServiceContainer.register(type: HttpRepository.self, HttpRepositoryImp())
            
            
            
        }
#else
        ServiceContainer.register(type: NetworkServiceManager.self, NetworkService())
        ServiceContainer.register(type: SupaBaseManager.self, SupaBaseService())
        ServiceContainer.register(type: SupaBaseRepository.self, SupaBaseRepoImpl())
        ServiceContainer.register(type: HttpRepository.self, HttpRepositoryImp())
        
        
#endif
        
        
        // Repositories
       // ServiceContainer.register(type: HttpRepository.self, HttpRepositoryImp())
        

    
    }
}


class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        //ServiceContainer.clearCache()
        #if DEBUG
        print("👷🏾‍♂️ Is UI Test Running: \(UITestingHelper.isUITesting)")
        #endif
        return true
    }
}
