//
//  TeamsSorter.swift
//  NCAAFTracker
//
//  Created by Daniel Espinosa on 10/19/22.
//

import Foundation

class TeamsSorter: NSObject {
    
    static public func sortTeamsById(teams: [Team]) -> [Team] {
        
        let sortedFilteredTeams = teams.sorted { lhs, rhs in
            let lhsId: String = lhs.id ?? "?"
            let rhsId: String = rhs.id ?? "?"
            let lhsInt: Int = Int(lhsId) ?? 0
            let rhsInt: Int = Int(rhsId) ?? 0
            return lhsInt < rhsInt
        }
        return sortedFilteredTeams
    }
    
    static public func sortTeamsByRanking(teams: [Team], sortType: Int = 0) -> [Team] {
        let sortedFilteredTeams = teams.sorted { lhs, rhs in
            let lhsRanking: Int = lhs.ranking ?? 0
            let rhsRanking: Int = rhs.ranking ?? 0
            
            let lhsSOSRank: Int = lhs.strengthOfScheduleRank ?? 0
            let rhsSOSRank: Int = rhs.strengthOfScheduleRank ?? 0

            
            switch sortType {
            case 0:
                return lhsRanking < rhsRanking
            case 1:
                return lhsRanking > rhsRanking
            case 2:
                return lhsSOSRank < rhsSOSRank
            default:
                return lhsRanking < rhsRanking
            }
        }
        return sortedFilteredTeams
    }
    
    static public func sortTeamsByAZ(teams: [Team]) -> [Team] {
        let sortedFilteredTeams = teams.sorted { lhs, rhs in
            let lhsName: String = lhs.name ?? ""
            let rhsName: String = rhs.name ?? ""
            return lhsName < rhsName
        }
        return sortedFilteredTeams
    }
}
