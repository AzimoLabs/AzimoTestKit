//
//  DictionaryAsserts.swift
//  AzimoTestKit
//
//  Created by Mateusz Kuznik on 04/05/2017.
//  Copyright © 2017 Azimo. All rights reserved.
//

import Foundation
import XCTest

public extension Dictionary {
    
    func containsItem<T>(forKey key: Key, withType expectedType: T.Type , file: StaticString = #file, line: UInt = #line) {
        let valueOptional = self[key]
        guard let value = valueOptional else {
            XCTFail("expected that \(self) will contain item with key: \(key)", file: file, line: line)
            return
        }
        
        guard let _ = value as? T else {
            let valueMirror = Mirror(reflecting: value)
            XCTFail("expected \(T.self) but was \(valueMirror.subjectType) - \(value)", file: file, line: line)
            return
        }
    }
    
    func containsItem<T: Equatable>(forKey key: Key, equalTo expectedItem: T, file: StaticString = #file, line: UInt = #line) {
        let valueOptional = self[key]
        guard let value = valueOptional else {
            XCTFail("expected that \(self) will contain item with key: \(key)", file: file, line: line)
            return
        }
        
        guard let castedValue = value as? T else {
            let valueMirror = Mirror(reflecting: value)
            XCTFail("expected \(T.self) but was \(valueMirror.subjectType) - \(value)", file: file, line: line)
            return
        }
        
        XCTAssertEqual(castedValue, expectedItem, file: file, line: line)
    }
}
