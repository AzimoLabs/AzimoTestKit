//
// Created by Mateusz Kuznik on 12/05/2017.
// Copyright (c) 2017 Azimo. All rights reserved.
//

import Foundation
import XCTest

public func Verify<T>(_ value: Any, isTypeOf expectedType: T.Type, file: StaticString = #file, line: UInt = #line) throws {
    guard let _ = value as? T else {
        let mirrorValue = Mirror(reflecting: value)
        let message = "Expected \(expectedType) but was \(mirrorValue.subjectType) (\(value))"
        XCTFail(message, file: file, line: line)
        throw message
    }
}

public func Verify<T:Equatable>(_ value: Any, isEqualTo expectedValue: T, file: StaticString = #file, line: UInt = #line) throws {
    guard let castedValue = value as? T else {
        let mirrorExpectedValue = Mirror(reflecting: expectedValue)
        let mirrorValue = Mirror(reflecting: value)
        let message = "Expected that \(value) is type of \(mirrorExpectedValue.subjectType) but was \(mirrorValue.subjectType)"
        XCTFail(message, file: file, line: line)
        throw message
    }
    XCTAssertEqual(castedValue, expectedValue, file: file, line: line)
}
