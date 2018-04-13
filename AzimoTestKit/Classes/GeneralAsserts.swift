//
// Created by Mateusz Kuznik on 12/05/2017.
// Copyright (c) 2017 Azimo. All rights reserved.
//

import Foundation
import XCTest

public func Verify<T>(_ value: Any, isTypeOf expectedType: T.Type, file: StaticString = #file, line: UInt = #line) {
    
    do {
        _ = try VerifyAndCast(value, isTypeOf: expectedType, file: file, line: line)
    } catch {
        let message = "\(error)"
        XCTFail(message, file: file, line: line)
    }
}

public func Verify<T: Equatable>(_ value: Any, isEqualTo expectedValue: T, file: StaticString = #file, line: UInt = #line) {
    guard let castedValue = value as? T else {
        let mirrorExpectedValue = Mirror(reflecting: expectedValue)
        let mirrorValue = Mirror(reflecting: value)
        let message = "Expected that \(value) is type of \(mirrorExpectedValue.subjectType) but was \(mirrorValue.subjectType)"
        XCTFail(message, file: file, line: line)
        return
    }
    XCTAssertEqual(castedValue, expectedValue, file: file, line: line)
}

public func VerifyAndCast<T>(_ value: Any, isTypeOf expectedType: T.Type, file: StaticString = #file, line: UInt = #line) throws -> T {
    guard let casted = value as? T else {
        let mirrorValue = Mirror(reflecting: value)
        let message = "Expected \(expectedType) but was \(mirrorValue.subjectType) (\(value))"
        throw message
    }
    return casted
}
