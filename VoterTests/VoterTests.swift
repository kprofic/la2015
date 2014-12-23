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

// Check calls check withing assertion clausure
func Check<X: Arbitrary>(prop: X -> Bool, desc: String) {
    XCTAssert(check(desc, prop), desc)
}

func Check<X: Arbitrary, Y: Arbitrary>(prop: (X, Y) -> Bool, desc: String) {
    XCTAssert(check(desc, prop), desc)
}

func Check<X: Arbitrary>(prop: [X] -> Bool, desc: String) {
    XCTAssert(check(desc, prop), desc)
}

extension Vote: Arbitrary {
    func smaller() -> Vote? {
        return nil
    }
    
    static func arbitrary() -> Vote {
        switch (arc4random() % 3) {
        case 0 :
            return Vote.Like
        default :
            return Vote.Neutral
        }
    }
}

func voteManagerAccumulatesVotes(votes: [Vote]) -> Bool {
    let vm = VoteManager()
    
    for v in votes {
        vm.makeVote(v)
    }

    return arrayIsEqualToArray(vm.votes, votes)
}

class VoterTests: XCTestCase {

    func testMath() {
        // extended inline lambda
        Check({(x: Int, y: Int) in
            x + y == y + x
        }, "Plus should be commutative 1")
        
        // pass function
        Check(plusIsCommutative, "Plus should be commutative 2")
    }
    
    func testVoteManager() {
        Check(voteManagerAccumulatesVotes, "VoteManager should accumulate votes")
    }
}



