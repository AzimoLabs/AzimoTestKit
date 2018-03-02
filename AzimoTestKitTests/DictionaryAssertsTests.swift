//
//  DictionaryAssertsTests.swift
//  AzimoTestKit
//
//  Created by Mateusz Kuznik on 04/05/2017.
//  Copyright © 2017 Azimo. All rights reserved.
//

import XCTest
import AzimoTestKit

class DictionaryAssertsTests: XCTestCase {

    func testVerifyDictionaryContainsItemWithType() throws {
        let dictionary = ["test": "bla"]
        try Verify(dictionary, hasItemWithKey: "test", ofType: String.self)
    }

    func testVerifyDictionaryContainsItemEqualTo() throws {
        let dictionary = ["test": "bla"]
        try Verify(dictionary, hasItemWithKey: "test", equalTo: "bla")
    }

    func testThatVerifyHasTheSameItemsAs() throws {

        let expectedDictionary: [String: String] = [
                "key1": "value1",
                "key2": "value2",
                "key3": "value3",
        ]

        let dictionaryToValidate: Any? = [
                "key1": "value1",
                "key2": "value2",
                "key3": "value3",
        ]

        try Verify(dictionaryToValidate, hasTheSameItemsAs: expectedDictionary)

    }

}
