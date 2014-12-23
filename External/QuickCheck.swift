//
//  QuickCheck.swift
//  Voter
//
//  Created by Krzysztof Profic on 23/12/14.
//  Copyright (c) 2014 Lambda Academy. All rights reserved.
//

//  Implementation based on QuickCheck by Chris Eidhof from "Functional Programming in Swift"

import Foundation

let numberOfIterations = 10

import Foundation

func iterateWhile<A>(condition: A -> Bool,
    initialValue: A,
    next: A -> A?) -> A {
        
        if let x = next(initialValue) {
            if condition(x) {
                return iterateWhile(condition, x, next)
            }
        }
        return initialValue
}

protocol Smaller {
    func smaller() -> Self?
}

protocol Arbitrary: Smaller {
    class func arbitrary() -> Self
}

struct ArbitraryI<T> {
    let arbitrary: () -> T
    let smaller: T -> T?
}

func checkHelper<A>(arbitraryInstance: ArbitraryI<A>,
    prop: A -> Bool, message: String) -> (Bool) {
        
        for _ in 0..<numberOfIterations {
            let value = arbitraryInstance.arbitrary()
            if !prop(value) {
                let smallerValue = iterateWhile({ !prop($0) }, value,
                    arbitraryInstance.smaller)
                println("\"\(message)\" doesn't hold: \(smallerValue)")
                return false
            }
        }
        println("\"\(message)\" passed \(numberOfIterations) tests.")
        return true
}

func check<X: Arbitrary>(message: String, prop: X -> Bool) -> (Bool) {
    let instance = ArbitraryI(arbitrary: { X.arbitrary() }, smaller: { $0.smaller() })
    return checkHelper(instance, prop, message)
}

func check<X: Arbitrary, Y: Arbitrary>(message: String, prop: (X, Y) -> Bool) -> (Bool) {
    let arbitraryTuple = { (X.arbitrary(), Y.arbitrary()) }
    let smaller: (X, Y) -> (X, Y)? = { (x, y) in
        if let newX = x.smaller() {
            if let newY = y.smaller() {
                return (newX, newY)
            }
        }
        return nil
    }
    
    let instance = ArbitraryI(arbitrary: arbitraryTuple, smaller: smaller)
    return checkHelper(instance, prop, message)
}

extension Int: Smaller {
    func smaller() -> Int? {
        return self == 0 ? nil : self / 2
    }
}
extension Int: Arbitrary {
    static func arbitrary() -> Int {
        return Int(arc4random())
    }
}
extension String: Smaller {
    func smaller() -> String? {
        return self.isEmpty ? nil
            : dropFirst(self)
    }
}

//extension CGSize: Arbitrary {
//    func smaller() -> CGSize? {
//        return nil
//    }
//    
//    static func arbitrary() -> Size {
//        return CGSizeMake(Float.arbitrary(), Float.arbitrary())
//    }
//}
//
//extension Float: Arbitrary {
//    func smaller() -> CGFloat? {
//        return nil
//    }
//    
//    static func arbitrary() -> CGFloat {
//        let random: CGFloat = CGFloat(arc4random())
//        let maxUint = CGFloat(UInt32.max)
//        return 10000 * ((random - maxUint/2) / maxUint)
//    }
//}