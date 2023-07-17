//
//  ContentView.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 16/05/2023.
//

import SwiftUI



struct Space: View {
    var width: CGFloat = 0.0
    var height: CGFloat = 0.0
    var body: some View {
        Spacer()
            .frame(width: width, height: height)
    }
}

struct ContentView: View {
    @EnvironmentObject private var energyVm: EnergyViewModel
    @State private var path = NavigationPath()
    private let outerDialSize: CGFloat = 200
    private let innerDialSize: CGFloat = 172
    private let setpointSize: CGFloat = 15
    private let ringSize: CGFloat = 220
    private let minTemperature: CGFloat = 4
    private let maxTemperature: CGFloat = 30
    @State private var currentTemperature: CGFloat = 0
    @State private var degrees: CGFloat = 36
    @State private var showStatus = false
    //Circle Timer
    @State private var borderanim1: CGFloat = 0.0
    let timer1 = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    @State private var borderanim2: CGFloat = 0.0
    let timer2 = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    //Gradient
    private let gradient = AngularGradient(
        gradient: Gradient(colors: [Color.orange, Color.pink]),
        center: .center,
        startAngle: .degrees(180),
        endAngle: .degrees(0))


    private let gradient2 = AngularGradient(
        gradient: Gradient(colors: [Color.purple, Color.blue]),
        center: .center,
        startAngle: .degrees(180),
        endAngle: .degrees(0))
    
    var degree: CGFloat = 0
    var ringValue: CGFloat {
        currentTemperature / 50
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack{
                
                HStack{
                    Circle()
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30)
                    Text("Good morning David")
                        .font(.system(size:15))
                        .foregroundColor(.white)
                        .padding(.leading, 10)
                }
                .frame(maxWidth: .infinity, alignment:  .leading)

                Space(height: 20)
                ZStack {
                    ZStack{
                        Circle()
                            .stroke(Color.gray, lineWidth: 15).opacity(0.3)
                            .frame(width: 250, height: 250, alignment: .center)
                        
                        
                        
                        Circle()
                            .trim( from: 0, to: self.borderanim1)
                            .stroke(gradient, style: StrokeStyle(lineWidth: 15, lineCap: .round))
                            .frame(width: 250, height: 250, alignment: .center)
                            .shadow(color: .black, radius: 5, x: 0.0, y: 0.0)
                            .rotationEffect(.degrees(-90))
                            .onReceive(timer1) { _ in
                                withAnimation {
                                    guard self.borderanim1 < 0.65 else { return }
                                    self.borderanim1 += 0.65
                                }
                            }
                        
                        
                    }
                    .frame(width: 300, height: 300, alignment: .center)
                    Circle()
                    
                        .stroke(Color.gray, lineWidth: 15).opacity(0.3)
                        .frame(width: 200, height: 200, alignment: .center)
                    
                    Circle()
                        .trim( from: 0, to: self.borderanim2)
                        .stroke(gradient2, style: StrokeStyle(lineWidth: 15, lineCap: .round))
                        .frame(width: 200, height: 200, alignment: .center)
                        .rotationEffect(.degrees(-270))
                        .shadow(color: .black, radius: 5, x: 0.0, y: 0.0)
                        .rotationEffect(.degrees(-90))
                        .onReceive(timer2) { _ in
                            withAnimation {
                                guard self.borderanim2 < 0.7 else { return }
                                self.borderanim2 += 0.7
                            }
                        }
                    Circle()
                    
                        .stroke(Color.gray, lineWidth: 15).opacity(0.3)
                        .frame(width: 140, height: 140, alignment: .center)
                    
                    Circle()
                        .trim( from: 0, to:
                                CGFloat( (energyVm.electricity.datum?.attributes?.carbon_kg ?? 0.0) / 2 )
                                
                               // self.borderanim2
                        
                        )
                        .stroke(gradient2, style: StrokeStyle(lineWidth: 15, lineCap: .round))
                        .frame(width: 140, height: 140, alignment: .center)
                        .rotationEffect(.degrees(-120))
                        .shadow(color: .black, radius: 5, x: 0.0, y: 0.0)
                        .rotationEffect(.degrees(-90))
                        .onReceive(timer2) { _ in
                            withAnimation {
                                guard self.borderanim2 < 0.7 else { return }
                                self.borderanim2 += 0.7
                            }
                        }
                    
                }
                
                Text("Today's activity")
                    .font(.system(size:25))
                    .foregroundColor(.white)
                Space(height: 20)
              // MARK: Containers ---------->
               
                NavigationLink {
                    energy_screen()
                } label: {
                    CarbonCard(name: "Energy", date: energyVm.result.value?.datum?.attributes?.estimated_at?.formatDate ?? "", value:String(  energyVm.result.value?.datum?.attributes?.carbon_kg ?? 0.0), image: "light")
                }
                .accentColor(.clear)
           
                NavigationLink {
                    vehicle_screen()
                } label: {
                    CarbonCard(name: "Vehicle", date: "07:10 AM - 13:30 PM", value: "49", image: "car")
                }
                .accentColor(.clear)
                
                NavigationLink {
                    flight_screen()
                } label: {
                    CarbonCard(name: "Flights", date: "07:10 AM - 13:30 PM", value: "49", image: "plane")
                }
                .accentColor(.clear) // Set the accent color to clear
                    
                Spacer()
            }
            .frame(maxHeight: .infinity, alignment: .topLeading)
            .padding(.horizontal, 25)
            .background(.black)
        .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    
    
    
    
    
    
    
    
    
    @ViewBuilder
    func CarbonCard(name: String, date: String, value: String, image: String)-> some View {
        
        Rectangle()
            .cornerRadius(5)
            .frame(height: 90)
            .foregroundColor(Color.gray.opacity(0.2))
            .overlay {
                HStack {
                    VStack(alignment: .leading) {
                        
                        Label {
                            Text(name)
                                .font(.system(size:20))
                                .foregroundColor(.white)
                        } icon: {
                            Image(image)
                                .resizable()
                                .scaledToFit()
                                .padding(5)
                                .foregroundColor(.white)
                                .frame(width: 35, height: 35)
                        }
                        
                        if(!date.isEmpty){
                            Spacer()
                                .frame(height: 8)
                            Text(date)
                                .font(.system(size:15))
                                .foregroundColor(.white)
                            
                        }
                    }
                    Spacer()
                    Text(value)
                        .font(.custom(Font.climateCrisis, size: 40))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.1), radius: 20)
                }
                .frame(maxWidth: .infinity, alignment:  .leading)
                .padding(.leading, 20)
                .padding(.trailing, 30)
            }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(EnergyViewModel())
    }
}
