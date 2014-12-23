//
//  VoteHandler.swift
//  Voter
//
//  Created by Krzysztof Profic on 14/12/14.
//  Copyright (c) 2014 Lambda Academy. All rights reserved.
//

import UIKit

class VoteManager: NSObject {
    var votes : Array<Vote> = [] //
    
    // https://github.com/hpique/SwiftSingleton
    class var sharedInstance: VoteManager {
        struct Singleton {
            static let instance = VoteManager()
        }

        return Singleton.instance
    }
    
    func makeVote(vote: Vote) {
        self.votes.append(vote)
        
        println("Votes: \(self.votes)")
        println("Median: \(self.median)")
        println()
    }


    func likes() -> Array<Vote> {
        return self.votes.filter {
            $0 == Vote.Like
        }
    }
    
    func neutrals() -> Array<Vote> {
        return self.votes.filter {
            $0 == Vote.Neutral
        }
    }
    
    func hates() -> Array<Vote> {
        return self.votes.filter {
            $0 == Vote.Hate
        }
    }
    
    var median: Vote {
        var grouppedVotes  = [self.likes(), self.hates(), self.neutrals()]
        grouppedVotes.sort({ $0.count < $1.count })
        
        if let median = grouppedVotes.last!.last {
            return median
        } else {
            return Vote.None
        }
    }
    
    // average
}
