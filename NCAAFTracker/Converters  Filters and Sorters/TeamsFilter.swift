//
//  TeamsFilter.swift
//  NCAAFTracker
//
//  Created by Daniel Espinosa on 10/19/22.
//

import Foundation

class TeamsFilter: NSObject {
    
    static func filterTeams(teams: [Team], query: String, shouldIncludeFCSTeam: Bool = false) -> [Team]{
        if (query == ""){
            return teams
        }
        
        let filteredTeams = teams.filter({ team in
            if (shouldIncludeFCSTeam && team.id == "0"){
                return true
            }
            guard let teamName = team.name?.lowercased() else { return false }
            return teamName.contains(query.lowercased())
        })
        return filteredTeams
    }
}
