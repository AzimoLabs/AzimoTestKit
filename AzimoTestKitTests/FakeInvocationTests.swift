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
    
//    func testThatParameterForKey_forNonExistingKey_willFail() {
//        let parameterName = "paramenterName"
//        let parameterValue = 20
//        let sut = FakeInvocation(method: "testMethod", parameters: [parameterName: parameterValue])
//
//        continueAfterFailure = false
//        let _: Int = sut.parameter(forKey: "_unexisting") //this is expected fail, test should pass
//    }
//
//    func testThatParameterForKey_forInvalidParameterType_willFall() {
//        let parameterName = "paramenterName"
//        let parameterValue = 20
//        let sut = FakeInvocation(method: "testMethod", parameters: [parameterName: parameterValue])
//
//        continueAfterFailure = false
//        let _: String = sut.parameter(forKey: parameterName) //this is expected fail, test should pass
//    }
    
}
