//
//  DictionaryAssets.swift
//  AzimoTestKit
//
//  Created by Mateusz Kuznik on 04/05/2017.
//  Copyright © 2017 Azimo. All rights reserved.
//

import XCTest
import AzimoTestKit

class DictionaryAssets: XCTestCase {

    func testVerifyDictionaryContainsItemWithType() {
        let dictionary = ["test": "bla"]
        Verify(dictionary, hasItemWithKey: "test", ofType: String.self)
    }

    func testVerifyDictionaryContainsItemEqualTo() {
        let dictionary = ["test": "bla"]
        Verify(dictionary, hasItemWithKey: "test", equalTo: "bla")
    }
    
}
