//
//  ChatScreen.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 08/08/2023.
//

import SwiftUI
import Charts

struct ChatScreen: View {
    
    let list : [DataModel]
    @State private var enteredText = ""
    
    var body: some View {
        VStack {
            Descriptions(title: "Carbon Chart", subTilte: flight)
            //Space(height: UIScreen.main.bounds.height / 5)
            Chart {
                ForEach(list) { list in
                    BarMark(x: .value("Month", list.name), y: .value("values", list.carbonKg))
                }
            }
           // .chartYScale(domain: 0...1000)
            .chartXAxis {
                AxisMarks(values: .automatic) { value in
                AxisValueLabel() { // construct Text here
                  if let intValue = value.as(String.self) {
                    Text("\(intValue)")
                      .font(.system(size: 10)) // style it
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
                      .font(.system(size: 10)) // style it
                      .foregroundColor(.white)
                  }
                }
              }
            }
            .frame(height:180)
            
              Text(enteredText)
                .foregroundColor(.white)
        
        
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding()
        .background(.black)
    }
}

struct ChatScreen_Previews: PreviewProvider {
    static var previews: some View {
        ChatScreen(list: mockResponse)
    }
}











extension String {
    func character(at index: Int) -> Character? {
        guard index >= 0 && index < count else { return nil }
        return self[self.index(startIndex, offsetBy: index)]
    }
}







