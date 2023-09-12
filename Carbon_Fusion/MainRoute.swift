//
//  MainRoute.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 12/09/2023.
//

import SwiftUI

struct MainRoute: View {
    @ObservedObject
    var router = Router<Routes>(root: .MainScreen)
    var body: some View {
        RouterView(router: router)  { path, val in
            switch path {
            case .MainScreen: ContentView()
            case.EnergyScreen: EnergyScreen()
            case.FlightScreen: FlightScreen()
            case.LogisticsScreen: LogisticScreen()
            case.chartScreen: ChatScreen(list: val as? [DataModel] ?? [])
            case .HistoryScreen: HistoryScreen(list: val as! [DataModel])
            }
        }
        
    }
}

struct MainRoute_Previews: PreviewProvider {
    static var previews: some View {
        MainRoute()
            .environmentObject(SupbaseViewModel())
            .environmentObject(EnergyViewModel())
            .environmentObject(FlightViewModel())
            .environmentObject(ShipViewModel())
            .environmentObject(Router(root: Routes.MainScreen))
    }
}
