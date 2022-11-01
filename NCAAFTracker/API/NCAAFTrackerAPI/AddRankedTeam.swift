//
//  AddWeeklyRankings.swift
//  NCAAFTracker
//
//  Created by Daniel Espinosa on 10/19/22.
//

import Foundation

extension NCAAFTrackerAPI {
    
    func addWeeklyRanking(teams: [Team]){
        for team in teams {
            addRankedTeam(team: team) { err in
                if let err = err {
                    print("-de-\(err)")
                }
            }
        }
    }
    
    func addRankedTeam(team: Team, completion: @escaping (String?) -> Void){
        do {
            try db.collection("WeeklyRankings").document("\(Version.shared.throughWeek)").collection("Rankings").document("\(String(describing: team.ranking!))").setData(from: team)
        } catch {
            completion("Error: not able to add ranked team")
        }
    }
}
