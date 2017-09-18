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

public func Verify<Key, Value:Equatable>(_ dictionary: [Key: Value], hasTheSameItemsAs expected: [Key: Value], file: StaticString = #file, line: UInt = #line) {
    expected.forEach { (key: Key, value: Value) in
        Verify(dictionary, hasItemWithKey: key, equalTo: value, file: file, line: line)
    }
}

public func Verify<Key, Value:Equatable>(_ anyObjectOptional: Any?, hasTheSameItemsAs expected: [Key: Value], file: StaticString = #file, line: UInt = #line) {

    guard let anyObject = anyObjectOptional else {
        XCTFail("Expected dictionary but was nil", file: file, line: line)
        return
    }

    guard let anyDictionary = anyObject as? [Key: Value] else {
        let expectedMirror = Mirror(reflecting: expected)
        let valueMirror = Mirror(reflecting: anyObject)
        XCTFail("Expected \(expectedMirror.subjectType) but was \(valueMirror)", file: file, line: line)
        return
    }

    if anyDictionary.count == expected.count {
        expected.forEach { (key: Key, value: Value) in
            Verify(anyDictionary, hasItemWithKey: key, equalTo: value, file: file, line: line)
        }
    } else {
        let valueKeys = Set(anyDictionary.keys)
        let expectedKeys = Set(expected.keys)

        let missingExpectedKeys = expectedKeys.subtracting(valueKeys)
        let redundantKeys = valueKeys.subtracting(expectedKeys)

        var missingKeysMessage = ""
        if missingExpectedKeys.isEmpty == false {
            missingKeysMessage = "Missing expected keys: \(missingExpectedKeys). "
        }

        var redundantKeysMessage = ""
        if redundantKeys.isEmpty == false {
            redundantKeysMessage = "Redundant keys: \(redundantKeys)."
        }

        XCTFail("\(missingKeysMessage)\(redundantKeysMessage)", file: file, line: line)
    }


}
