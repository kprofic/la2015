//
//  Helpers.swift
//  Voter
//
//  Created by Krzysztof Profic on 23/12/14.
//  Copyright (c) 2014 Lambda Academy. All rights reserved.
//

import Foundation

func arrayIsEqualToArray<T: Equatable>(array: Array<T>, another: Array<T>) -> Bool {
    return equal(array, another, {(x: T, y: T) in
        return x == y
    })
}