//
//  FakeInvocationTests.swift
//  AzimoTestKitTests
//
//  Created by Mateusz Kuznik on 19/09/2017.
//  Copyright © 2017 Azimo. All rights reserved.
//

import XCTest
import AzimoTestKit

class FakeInvocationTests: XCTestCase {
    
    func testThatParameterForKey_forExistingKey_willReturnThisKey() throws {
        let parameterName = "paramenterName"
        let parameterValue = 20
        let sut = FakeInvocation(method: "testMethod", parameters: [parameterName: parameterValue])
        
        let parametr: Int = try sut.parameter(forKey: parameterName)
        
        XCTAssertEqual(parametr, parameterValue)
    }
    
//    func testThatParameterForKey_forNonExistingKey_willFail() throws {
//        let parameterName = "paramenterName"
//        let parameterValue = 20
//        let sut = FakeInvocation(method: "testMethod", parameters: [parameterName: parameterValue])
//
//        continueAfterFailure = false
//
//        do {
//            let unexpectedValue: Int = try sut.parameter(forKey: "_unexisting") 
//            XCTFail("\(unexpectedValue) is unexpected. parameter(forKey:) should throw an error")
//        } catch { }
//    }
//
//    func testThatParameterForKey_forInvalidParameterType_willFall() {
//        let parameterName = "paramenterName"
//        let parameterValue = 20
//        let sut = FakeInvocation(method: "testMethod", parameters: [parameterName: parameterValue])
//
//        continueAfterFailure = false
//        do {
//            let unexpectedValue: String = try sut.parameter(forKey: parameterName)
//            XCTFail("\(unexpectedValue) is unexpected. parameter(forKey:) should throw an error")
//        } catch { }
//    }
//
}
