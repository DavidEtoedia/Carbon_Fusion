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
            
            PINCodeView(pinCode: $enteredText)
           // CustomKeypadView(text: $enteredText)
        
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






struct CustomKeypadView: View {
    @Binding var text: String
    
    let keypadRows: [[String]] = [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        ["", "0", "Delete"]
    ]
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach(keypadRows, id: \.self) { row in
                HStack(spacing: 10) {
                    ForEach(row, id: \.self) { key in
                        Button(action: {
                            if key == "Delete" {
                                text = String(text.dropLast())
                            } else {
                                text += key
                            }
                        }) {
                            if key == "Delete" {
                                Image(systemName: "delete.left")
                                    .font(.system(size: 24))
                                    .foregroundColor(.red)
                            } else {
                                Text(key)
                                    .font(.system(size: 24))
                                    .frame(width: 60, height: 60)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(10)
                            }
                        }
                    }
                }
            }
        }
        .padding()
    }
}






struct PINCodeView: View {
    @Binding var pinCode: String
    let maxDigits = 4
    
    let keypadRows: [[String]] = [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        ["", "0", "Delete"]
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 15) {
                ForEach(0..<maxDigits, id: \.self) { index in
                    Text(pinCode.count > index ? "•" : "")
                        .font(.title)
                        .frame(width: 50, height: 50)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                }
            }
            
            ForEach(keypadRows, id: \.self) { row in
                HStack(spacing: 10) {
                    ForEach(row, id: \.self) { key in
                        Button(action: {
                            if key == "Delete" {
                                pinCode = String(pinCode.dropLast())
                            } else if pinCode.count < maxDigits {
                                pinCode.append(key)
                            }
                        }) {
                            if key == "Delete" {
                                Image(systemName: "delete.left")
                                    .font(.system(size: 24))
                                    .foregroundColor(.red)
                            } else {
                                Text(key)
                                    .font(.system(size: 24))
                                    .frame(width: 60, height: 60)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(10)
                            }
                        }
                    }
                }
            }
        }
        .padding()
    }
}


struct PinCodeBox: View {
    var value: Character?
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 50, height: 50)
            .overlay(
                Text(value.map(String.init) ?? "")
                    .font(.title)
            )
            .foregroundColor(Color.gray.opacity(0.2))
    }
}

extension String {
    func character(at index: Int) -> Character? {
        guard index >= 0 && index < count else { return nil }
        return self[self.index(startIndex, offsetBy: index)]
    }
}







