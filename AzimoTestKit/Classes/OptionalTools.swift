//
//  OptionalTools.swift
//  AzimoTestKit
//
//  Created by Mateusz Kuznik on 25/01/2018.
//  Copyright © 2018 Azimo. All rights reserved.
//

import Foundation
import XCTest

extension Optional {
    
    //thanks for Bartosz Polaczyk 👏: https://www.slideshare.net/BartoszPolaczyk1/lets-meet-your-expectations
    func unwraped(file: StaticString = #file, line: UInt = #line) throws -> Wrapped {
        switch self {
        case .some(let wrappedValue):
            return wrappedValue
        case .none:
            let message = "Found unexpected nil value in (#file),l: (line)"
            XCTFail(message, file:file, line:line)
            throw message
        }
    }
    
}
