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
                        .frame(width: 50, height: 50)
                    Text("Good morning David")
                        .font(.system(size:20))
                        .foregroundColor(.white)
                        .padding(.leading, 10)
                }
                .frame(maxWidth: .infinity, alignment:  .leading)

                Space(height: 60)
                ZStack {
    //                Circle()
    //                    .fill(LinearGradient(colors: [Color.red, Color.green], startPoint: .topLeading, endPoint: .bottomTrailing))
    //                    .frame(width: outerDialSize, height: outerDialSize)
    //                    .shadow(color: .black.opacity(0.2), radius: 60, x: 0, y: 30) // drop shadow 1
    //                    .shadow(color: .black.opacity(0.2), radius: 16, x: 0, y: 8) // drop shadow 2
    //                    .overlay {
    //                        // MARK: Outer Dial Border
    //                        Circle()
    //                            .stroke(LinearGradient(colors: [.white.opacity(0.2), .black.opacity(0.19)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1)
    //                    }
    //                    .overlay {
    //                        // MARK: Outer Dial Inner Shadow
    //                        Circle()
    //                            .stroke(.white.opacity(0.1), lineWidth: 4)
    //                            .blur(radius: 8)
    //                            .offset(x: 3, y: 3)
    //                            .mask {
    //                                Circle()
    //                                    .fill(LinearGradient(colors: [.black, .clear],startPoint: .topLeading, endPoint: .bottomTrailing))
    //                            }
    //                }
                    
                    // MARK: Inner Dial
    //                Circle()
    //                    .fill(LinearGradient(colors: [Color.red, Color.green], startPoint: .topLeading, endPoint: .bottomTrailing))
    //                    .frame(width: innerDialSize, height: innerDialSize)
                    
                    // MARK: Temperature Setpoint
    //                Circle()
    //                    .fill(LinearGradient(colors: [Color.red, Color.green], startPoint: .topLeading, endPoint: .bottomTrailing))
    //                    .frame(width: setpointSize, height: setpointSize)
    //                    .frame(width: innerDialSize, height: innerDialSize, alignment: .top)
    //                    .offset(x: 0, y: 7.5)
    //                    .rotationEffect(.degrees(degrees + 180))
    //                    .animation(.easeInOut(duration: 1), value: degrees)
                    Circle()
                        .inset(by: 2)
                        .trim(from: 0.15, to: min(ringValue, 0.85))
                        .stroke(
                            LinearGradient(colors: [Color.blue, Color.green], startPoint: .topLeading, endPoint: .bottomTrailing),
                            style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round)
                        )
                        .frame(width: ringSize, height: ringSize)
                        .rotationEffect(.degrees(90))
                        .animation(.linear(duration: 1), value: ringValue)
                    Circle()
                        .inset(by: 2)
                        .trim(from: 0.15, to: min(ringValue, 0.85))
                        .stroke(
                            LinearGradient(colors: [Color.blue, Color.green], startPoint: .topLeading, endPoint: .bottomTrailing),
                            style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round)
                        )
                        .frame(width: 180, height: 180)
                        .rotationEffect(.degrees(90))
                        .animation(.linear(duration: 1), value: ringValue)
                    Text("49")
                        .font(.custom(Font.climateCrisis, size: 50))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.1), radius: 20)
                }
                
                Text("Today's activity")
                    .font(.system(size:30))
                    .foregroundColor(.white)
                Space(height: 30)
              // MARK: Containers ---------->
                Rectangle()
                    .cornerRadius(25)
                    .frame(height: 90)
                    .foregroundColor(Color("power"))
                    .overlay {
                        HStack {
                            VStack(alignment: .leading) {
                                
                                Label {
                                    Text("Good")
                                        .font(.system(size:20))
                                        .foregroundColor(.black)
                                } icon: {
                                    Image("light")
                                        .resizable()
                                        .scaledToFit()
                                        .padding(5)
                                        .foregroundColor(.white)
                                        .frame(width: 30, height: 30)
                                    
                                        .background(Color(.white))
                                        .clipShape(Circle())
                                }
                                Spacer()
                                    .frame(height: 8)
                                Text("  07:10 AM - 13:30 PM")
                                    .font(.system(size:15))
                                    .foregroundColor(.black)
                                
                            }
                            Spacer()
                            Text("48")
                                .font(.custom(Font.climateCrisis, size: 40))
                                .foregroundColor(.white)
                                .shadow(color: .black.opacity(0.1), radius: 20)
                            //.padding(.trailing, 10)
                        }
                        .frame(maxWidth: .infinity, alignment:  .leading)
                        .padding(.leading, 30)
                        .padding(.trailing, 30)
                    }
                 
           
                NavigationLink {
                    energy_screen()
                } label: {
                    Rectangle()
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .cornerRadius(25)
                        .frame(height: 90)
        //                .foregroundColor(Color("vehicle"))
                        .overlay {
                            HStack {
                                VStack(alignment: .leading) {
                                    
                                    Label {
                                        Text("Good year")
                                            .font(.system(size:20))
                                            .foregroundColor(.black)
                                    } icon: {
                                        Image("car")
                                            .resizable()
                                            .scaledToFit()
                                            .padding(5)
                                            .foregroundColor(.white)
                                            .frame(width: 30, height: 30)
                                            .background(Color(.white))
                                            .clipShape(Circle())
                                    }
                                    Spacer()
                                        .frame(height: 8)
                                    Text("  07:10 AM - 13:30 PM")
                                        .font(.system(size:15))
                                        .foregroundColor(.black)
                                    
                                }
                                Spacer()
                                Text("49")
                                    .font(.custom(Font.climateCrisis, size: 40))
                                    .foregroundColor(.white)
                                    .shadow(color: .black.opacity(0.1), radius: 20)
                                //.padding(.trailing, 10)
                            }
                            .frame(maxWidth: .infinity, alignment:  .leading)
                            .padding(.leading, 30)
                            .padding(.trailing, 30)
                        }
                }

                
                Rectangle()
                    .cornerRadius(25)
                    .frame(height: 90)
                    .foregroundColor(Color("flight"))
                    .overlay {
                        HStack {
                            VStack(alignment: .leading) {
                                
                                Label {
                                    Text("Good")
                                        .font(.system(size:20))
                                        .foregroundColor(.black)
                                } icon: {
                                    Image("plane")
                                        .resizable()
                                        .scaledToFit()
                                        .padding(5)
                                        .foregroundColor(.white)
                                        .frame(width: 30, height: 30)
                                        .background(Color(.white))
                                        .clipShape(Circle())
                                }
                                Spacer()
                                    .frame(height: 8)
                                Text("  07:10 AM - 13:30 PM")
                                    .font(.system(size:15))
                                    .foregroundColor(.black)
                                
                            }
                            Spacer()
                            Text("49")
                                .font(.custom(Font.climateCrisis, size: 40))
                                .foregroundColor(.white)
                                .shadow(color: .black.opacity(0.1), radius: 20)
                            //.padding(.trailing, 10)
                        }
                        .frame(maxWidth: .infinity, alignment:  .leading)
                        .padding(.leading, 30)
                        .padding(.trailing, 30)
                    }
                    
                Spacer()
            }
            .frame(maxHeight: .infinity, alignment: .topLeading)
            .padding(.horizontal, 25)
            .onAppear{
                currentTemperature = 50
                         degrees = currentTemperature / 40 * 360
                //            Task{
                //                let elect = ElectricityReq(type: "electricity", electricityUnit: "mwh", electricityValue: 3, country: "us", state: "fl")
                //
                //                NetworkManager.shared.postElect(body: elect) { result in
                //                    switch result {
                //
                //                    case .success(_):
                //                        print("success")
                //                    case .failure(let err):
                //                        print(err.localizedDescription)
                //                    }
                //                }
                //
                //            }
                
            }
            .background(.black)
        .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
