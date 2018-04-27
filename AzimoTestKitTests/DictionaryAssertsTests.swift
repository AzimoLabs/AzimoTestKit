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

    func testVerifyDictionaryContainsItemWithType() {
        let dictionary = ["test": "bla"]
        Verify(dictionary, hasItemWithKey: "test", ofType: String.self)
    }

    func testVerifyDictionaryContainsItemEqualTo() {
        let dictionary = ["test": "bla"]
        Verify(dictionary, hasItemWithKey: "test", equalTo: "bla")
    }

    func testThatVerifyHasTheSameItemsAs() {

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

        Verify(dictionaryToValidate, hasTheSameItemsAs: expectedDictionary)

    }
//
//    func testThatVerifyHasTheSameItemsAs_forMissingKay_willThrow() throws {
//
//        let expectedDictionary: [String: String] = [
//                "key1": "value1",
//                "key2": "value2",
//                "key3": "value3",
//        ]
//
//        let dictionaryToValidate: Any? = [
//                "key1": "value1",
//                "key2": "value2",
//        ]
//
//        Verify(dictionaryToValidate, hasTheSameItemsAs: expectedDictionary)
//
//    }
//
//    func testThatVerifyHasTheSameItemsAs_forRedundantKay_willThrow() throws {
//
//        let expectedDictionary: [String: String] = [
//                "key1": "value1",
//                "key2": "value2",
//                "key3": "value3",
//        ]
//
//        let dictionaryToValidate: Any? = [
//                "key1": "value1",
//                "key2": "value2",
//                "key3": "value3",
//                "key4": "value4",
//        ]
//
//        Verify(dictionaryToValidate, hasTheSameItemsAs: expectedDictionary)
//
//    }

}
