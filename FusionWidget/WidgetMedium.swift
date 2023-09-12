//
//  WidgetMedium.swift
//  FusionWidgetExtension
//
//  Created by Inyene Etoedia on 03/09/2023.
//

import SwiftUI
import WidgetKit
import Charts

struct WidgetMedium: View {
    var entry: SimpleEntry
    @State private var borderanim1: CGFloat = 0.0
    
    //Gradient
    private let gradient = AngularGradient(
        gradient: Gradient(colors: [Color.orange, Color.pink]),
        center: .center,
        startAngle: .degrees(180),
        endAngle: .degrees(0))

    let list : [(name: String, carbonKg: Double, createdAt: String )] = [
  
        ("Energy", 7.4, "2023-06-29 10:09:08.687"),
        ("Flight", 4.4, "2023-08-29 11:09:08.687"),
        ("Logistics", 10.4, "2023-05-29 05:09:08.687"),
        ("Logistics", 24.4, "2023-05-29 05:09:08.687"),
        ("Flight", 3.4, "2023-07-29 06:09:08.687"),
        ("Energy", 5.4, "2023-08-29 11:09:08.687"),
    
    ]
    
    var body: some View {
        let totalCarbonKg = entry.dataModel.reduce(0.0) { (result, item) in
            return result + item.carbonKg
        }
        HStack(spacing: 20){
            VStack(alignment:.leading) {
                Text("Total emission")
                    .font(.system(size:14))
                    .foregroundColor(.white.opacity(0.7))
                ZStack{
                    VStack {
                        Text(String(totalCarbonKg.rounded(toDecimalPlaces: 1)))
                            .font(.system(size: 33, weight: .black))
                            .foregroundColor(.white)
                        
                        
                        Text("CO2e/kg")
                            .font(.system(size:12))
                            .foregroundColor(.white)
                        
                        
                    }
                    Circle()
                        .stroke(Color.gray, lineWidth: 10).opacity(0.3)
                        .frame(width: 100, height: 100, alignment: .center)
                    
                    Circle()
                        .trim( from: 0, to: self.borderanim1)
                        .stroke(gradient, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                        .frame(width: 100, height: 100, alignment: .center)
                        .shadow(color: .black, radius: 5, x: 0.0, y: 0.0)
                        .rotationEffect(.degrees(180))
                    
                }
            }
            VStack {
               
                Chart {
                    ForEach(entry.dataModel) { list in
                        BarMark(x: .value("Month", list.name), y: .value("values", list.carbonKg)
                        )
                        
                    }
                }
               // .chartYScale(domain: 0...1000)
                .chartXAxis {
                    AxisMarks(values: .automatic) { value in
                    AxisValueLabel() { // construct Text here
                      if let intValue = value.as(String.self) {
                        Text("\(intValue)")
                          .font(.system(size: 8)) // style it
                          .foregroundColor(.white)
                      }
                    }
                  }
                }
                
                .chartYAxis {
                    AxisMarks(values: .automatic) { value in
                        AxisGridLine(centered: true, stroke: StrokeStyle(dash: [1, 2]))
                            .foregroundStyle(Color.cyan)
                          AxisTick(centered: true, stroke: StrokeStyle(lineWidth: 2))
                            .foregroundStyle(Color.red)
                    AxisValueLabel() { // construct Text here
                      if let intValue = value.as(Int.self) {
                        Text("\(intValue) kg")
                          .font(.system(size: 8)) // style it
                          .foregroundColor(.white)
                      }
                    }
                  }
                }
                .frame(height:130)
                .padding(.top, 15)
            
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            
        }
        .padding(.leading, 30)
        .padding(.trailing, 15)
        .frame(maxWidth:.infinity, maxHeight: .infinity, alignment: .leading)
        .background(.black)
        .widgetURL(URL(string: "app://fusionWiget/chart"))
        .onAppear{
            withAnimation {
                self.borderanim1 =
                CGFloat( totalCarbonKg / 100)
            }
        }
 
    }
}


struct WidgetMedium_Previews: PreviewProvider {
    static var previews: some View {
        let sampleEntry = SimpleEntry(date: Date(), dataModel: [
            .init(id: UUID(), carbonKg: 0.5, createdAt: "2023-03-04 11:09:02.687", name: "Logistics"),
            .init(id: UUID(), carbonKg: 1.5, createdAt: "2023-03-04 11:09:02.687", name: "Flight"),
            .init(id: UUID(), carbonKg: 1.2, createdAt: "2023-03-04 11:09:02.687", name: "Logistics"),
            .init(id: UUID(), carbonKg: 1.5, createdAt: "2023-03-04 11:09:02.687", name: "Energy"),
            .init(id: UUID(), carbonKg: 1.0, createdAt: "2023-03-04 11:09:02.687", name: "Flight"),
           
        ])
        
        return WidgetMedium(entry: sampleEntry)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
