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
    

    func testVerifyValueIsTypOf() throws {
        let stringValue: Any = "Test String"

        try Verify(stringValue, isTypeOf: String.self)
    }

//    func testVerifyValueIsTypOf_forInvalidType_willFail() throws {
//        let stringValue: Any = "Test String"
//
//        try Verify(stringValue, isTypeOf: Int.self)
//    }
    
}
