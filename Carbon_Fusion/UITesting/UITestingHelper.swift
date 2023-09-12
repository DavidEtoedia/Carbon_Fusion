//
//  UITestingHelper.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 31/08/2023.
//
#if DEBUG

import Foundation

struct UITestingHelper {
    
    static var isUITesting: Bool {
        ProcessInfo.processInfo.arguments.contains("-ui-testing")
    }
    
}

#endif
