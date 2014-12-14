//
//  Vote.swift
//  Voter
//
//  Created by Krzysztof Profic on 14/12/14.
//  Copyright (c) 2014 Lambda Academy. All rights reserved.
//

import Foundation

// value type
enum Vote : String, Printable {
    case Like = "Like Vote"
    case Neutral = "Neutral Vote"
    case Hate = "Hate Vote"
    case None = "No vote"
    
    var description : String {
        return self.rawValue
    }
}