//
//  KeyboardUtil.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 18/07/2023.
//

import Foundation
import UIKit


class KeyboardHelper {
    static func closeKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        UIApplication.shared.sendAction(#selector(UIResponder.becomeFirstResponder), to: nil, from: nil, for: nil)
    }
}
