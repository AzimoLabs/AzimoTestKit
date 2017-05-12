//
//  GeneralAssertsTest.swift
//  AzimoTestKit
//
//  Created by Mateusz Kuznik on 12/05/2017.
//  Copyright © 2017 Azimo. All rights reserved.
//

import XCTest
import AzimoTestKit

class GeneralAssertsTest: XCTestCase {
    

    func testVerifyValueIsTypOf() {
        let stringValue: Any = "Test String"

        Verify(stringValue, isTypeOf: String.self)
    }
    
}
