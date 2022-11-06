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
            case 3:
                let lhsPPGScored: Double = lhs.ppgScored ?? 0
                let rhsPPGScored: Double = rhs.ppgScored ?? 0
                return lhsPPGScored > rhsPPGScored
            case 4:
                let lhsPPGSAllowed: Double = lhs.ppgAllowed ?? 0
                let rhsPPGAllowed: Double = rhs.ppgAllowed ?? 0
                return lhsPPGSAllowed < rhsPPGAllowed
            case 5:
                let lhsScoreDifferential: Int = lhs.scoreDifferential ?? 0
                let rhsScoreDifferential: Int = rhs.scoreDifferential ?? 0
                return lhsScoreDifferential > rhsScoreDifferential
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
