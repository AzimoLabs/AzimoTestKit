//
//  DictionaryAsserts.swift
//  AzimoTestKit
//
//  Created by Mateusz Kuznik on 04/05/2017.
//  Copyright © 2017 Azimo. All rights reserved.
//

import Foundation
import XCTest


public func Verify<T, Key, Value>(_ dictionary: [Key: Value], hasItemWithKey key: Key, ofType type: T.Type, file: StaticString = #file, line: UInt = #line) {
    let valueOptional = dictionary[key]
    guard let value = valueOptional else {
        XCTFail("expected that \(dictionary) will contain item with key: \(key)", file: file, line: line)
        return
    }

    Verify(value, isTypeOf: type, file: file, line: line)
}

public func Verify<T:Equatable, Key, Value>(_ dictionary: [Key: Value], hasItemWithKey key: Key, equalTo expectedItem: T, file: StaticString = #file, line: UInt = #line) {
    let valueOptional = dictionary[key]
    guard let value = valueOptional else {
        XCTFail("expected that \(dictionary) will contain item with key: \(key)", file: file, line: line)
        return
    }

    Verify(value, isEqualTo: expectedItem, file: file, line: line)
}
