//
//  Game.swift
//  NCAAFTracker
//
//  Created by Daniel Espinosa on 10/9/22.
//

import Foundation
import FirebaseFirestoreSwift

struct Game: Codable, Identifiable {
    @DocumentID var id: String?
    let a: Int?
    let aScore: Int?
    let b: Int?
    let bScore: Int?
    
    var aName: String?
    var bName: String?
    

    var winnerId: Int? {
        if ( a != nil && b != nil && aScore != nil && bScore != nil){
            return aScore! > bScore! ? a : b
        } else {
            return nil
        }
    }
    var winnerName: String?
    
    var winnerScore: Int? {
        if (aScore != nil && bScore != nil){
            return aScore! > bScore! ? aScore! : bScore
        } else {
            return nil
        }
    }

    var loserId: Int? {
        if ( a != nil && b != nil && aScore != nil && bScore != nil){
            return aScore! > bScore! ? b : a
        } else {
            return nil
        }
    }
    var loserName: String?
    var loserScore: Int? {
        if (aScore != nil && bScore != nil){
            return aScore! > bScore! ? bScore! : aScore
        } else {
            return nil
        }
    }
    
    var scoreDifference: Int? {
        if (aScore != nil && bScore != nil){
            return abs(aScore! - bScore!)
        } else {
            return nil
        }
    }
    
    var winnerRecord: String?
    var loserRecord: String?

}
