//
//  extensions.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 30/06/2023.
//

import Foundation


//let decimalValue = Decimal(value)
//    let rounded = decimalValue.rounded(scale: 2, roundingMode: .up)
//    return "\(rounded)"


extension Double{
    var cvDouble: Double {
        return ceil(self)
       
    }
}

extension String {
    var formatDate : String {
        if(self.isEmpty){
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" // Specify the input format
        
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "MMM dd, yyyy" // Specify the desired output format
            return dateFormatter.string(from: date)
        } else {
            return ""
        }
    }
}


func convertDateFormat(inputDate: String) -> String {

     let olDateFormatter = DateFormatter()
     olDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

     let oldDate = olDateFormatter.date(from: inputDate)

     let convertDateFormatter = DateFormatter()
     convertDateFormatter.dateFormat = "MMM dd yyyy h:mm a"

     return convertDateFormatter.string(from: oldDate!)
}

extension String{
    var displayTime: String {
        let olDateFormatter = DateFormatter()
        olDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        let oldDate = olDateFormatter.date(from: self)

        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = "MMM dd yyyy h:mm a"

        return convertDateFormatter.string(from: oldDate!)
    }
}



extension Double {
    func rounded(toDecimalPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded(.up) / divisor
    }
}
