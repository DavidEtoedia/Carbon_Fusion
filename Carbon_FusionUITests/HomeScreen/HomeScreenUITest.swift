//
//  HomeScreenUITest.swift
//  Carbon_FusionUITests
//
//  Created by Inyene Etoedia on 31/08/2023.
//

import XCTest

 class HomeScreenUITest: XCTestCase {
     private var app: XCUIApplication!
     
     override func setUp() {
         continueAfterFailure = false
         app = XCUIApplication()
         app.launchArguments.append("-ui-testing")
        // app.launchArguments = ["-ui-testing"]
         app.launchEnvironment = ["-networking-success":"1"]
         app.launch()
     }
    
     override func tearDown() {
         app = nil
     }
     
    
    func test_buttonTest_isVisble() {
        
        let homeText = app.buttons["View History"]
        let logistics = app.buttons["logistics"]
        let energy = app.buttons["Energy"]
        let flight = app.buttons["Flights"]
        
        XCTAssert(homeText.exists, "View History Button is Visible")
        XCTAssert(logistics.exists, "Logistics Button is Visible")
        XCTAssert(energy.exists, "Energy Button is Visible")
       XCTAssert(flight.exists, "Flights Button is Visible")
    }
}
