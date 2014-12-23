//
//  Helpers.swift
//  Voter
//
//  Created by Krzysztof Profic on 23/12/14.
//  Copyright (c) 2014 Lambda Academy. All rights reserved.
//

import Foundation

func arrayIsEqualToArray<T: Equatable>(array: Array<T>, another: Array<T>) -> Bool {
    if(array.count != another.count) {
        return false
    }
    
    for i in 0..<array.count {
        let el1 = array[i];
        let el2 = another[i];
        if (el1 != el2) {
            return false
        }
    }
    
    return true
}
