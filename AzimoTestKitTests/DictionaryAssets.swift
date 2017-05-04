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
    
    func testDictionaryContainsItemWithType() {
        let dictionary = ["test": "bla"]
        dictionary.containsItem(forKey: "test", withType: String.self)
    }
    
    func testDictionaryContainsItemEqualTo() {
        let dictionary = ["test": "bla"]
        dictionary.containsItem(forKey: "test", equalTo: "bla")
    }
    
}
