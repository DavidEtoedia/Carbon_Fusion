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
            ServiceContainer.register(type: ApiRepository.self, MockApiImplementation())
            ServiceContainer.register(type: MockSupaBaseManagerProtocol.self, MockSupaBaseMangerImpl())
            ServiceContainer.register(type: SupabaseRepository.self, MockSupaBaseRepository())
            ServiceContainer.register(type: SupaBaseUsecase.self, SupaBaseUsecase())
            ServiceContainer.register(type: ApiUsecase.self, ApiUsecase())
            
        }
        else{
            ServiceContainer.register(type: NetworkServiceManager.self, NetworkService())
            ServiceContainer.register(type: SupaBaseManager.self, SupaBaseService.shared)
            ServiceContainer.register(type: SupabaseRepository.self, SupabaseServiceImpl())
            ServiceContainer.register(type: ApiRepository.self, ApiImplementation())
            ServiceContainer.register(type: HttpNetworkService.self, HttpNetworkService())
            ServiceContainer.register(type: SupaBaseUsecase.self, SupaBaseUsecase())
            ServiceContainer.register(type: ApiUsecase.self, ApiUsecase())
            
            
            
        }
#else
        ServiceContainer.register(type: NetworkServiceManager.self, NetworkService())
        ServiceContainer.register(type: SupaBaseManager.self, SupaBaseService.shared)
        ServiceContainer.register(type: SupabaseRepository.self, SupabaseServiceImpl())
        ServiceContainer.register(type: ApiRepository.self, ApiImplementation())
        ServiceContainer.register(type: HttpNetworkService.self, HttpNetworkService())
        ServiceContainer.register(type: SupaBaseUsecase.self, SupaBaseUsecase())
        ServiceContainer.register(type: ApiUsecase.self, ApiUsecase())
        
        
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
