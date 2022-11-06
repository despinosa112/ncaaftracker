//
//  TeamConverter.swift
//  NCAAFTracker
//
//  Created by Daniel Espinosa on 10/18/22.
//

import Foundation

class TeamConverter: NSObject {
    
    static func convertToTeamsArray(teamsMap: [Int: Team]) -> [Team] {
        var teamsToReturn = [Team]()
        for (_, teamVal) in teamsMap {
            teamsToReturn.append(teamVal)
        }
        return teamsToReturn
    }
}
