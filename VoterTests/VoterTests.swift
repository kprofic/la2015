//
//  VoterTests.swift
//  VoterTests
//
//  Created by Krzysztof Profic on 14/12/14.
//  Copyright (c) 2014 Lambda Academy. All rights reserved.
//

import UIKit
import XCTest

func plusIsCommutative(x: Int, y: Int) -> Bool {
    return x + y == y + x
}

func CheckAssert<X: Arbitrary>(prop: X -> Bool, desc: String) {
    XCTAssert(check(desc, prop), desc)
}

func CheckAssert<X: Arbitrary, Y: Arbitrary>(prop: (X, Y) -> Bool, desc: String) {
    XCTAssert(check(desc, prop), desc)
}

class VoterTests: XCTestCase {

    func testExample() {
        
        // checking inline lambda
        CheckAssert({ $0 + $1 == $1 + $0 }, "Plus should be commutative 1")
        
        // extended inline lambda
        CheckAssert({(x: Int, y: Int) in
            x + y == y + x
        }, "Plus should be commutative 2")
        
        CheckAssert(plusIsCommutative, "Plus should be commutative 3")
    }
    
}



