//
// Created by Mateusz Kuznik on 12/05/2017.
// Copyright (c) 2017 Azimo. All rights reserved.
//

import Foundation
import XCTest

public func Verify<T>(_ value: Any, isTypeOf expectedType: T.Type, file: StaticString = #file, line: UInt = #line) {
    guard let _ = value as? T else {
        let mirrorValue = Mirror(reflecting: value)
        XCTFail("Expected \(expectedType) but was \(mirrorValue.subjectType) (\(value))", file: file, line: line)
        return
    }
}

public func Verify<T:Equatable>(_ value: Any, isEqualTo expectedValue: T, file: StaticString = #file, line: UInt = #line) {
    guard let castedValue = value as? T else {
        let mirrorExpectedValue = Mirror(reflecting: expectedValue)
        let mirrorValue = Mirror(reflecting: value)
        XCTFail("Expected \(mirrorExpectedValue.subjectType)(\(expectedValue)) but was \(mirrorValue.subjectType) (\(value))", file: file, line: line)
        return
    }
    XCTAssertEqual(castedValue, expectedValue, file: file, line: line)
}
