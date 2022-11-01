//
//  Team.swift
//  NCAAFTracker
//
//  Created by Daniel Espinosa on 10/9/22.
//

import Foundation
import FirebaseFirestoreSwift

struct Team: Codable, Identifiable {
    @DocumentID var id: String?
    let name: String?
    let conId: Int?
    
    var totalWins: Int?
    var totalLosses: Int?
    
    var fbsDefeatedOpponentIds: [Int]?
    var fbsDefeatedOpponentIdsString: String? {
        var idStrs = ""
        guard let ids = self.fbsDefeatedOpponentIds else { return nil }
        for id in ids {
            idStrs += "\(id) ,"
        }
        return idStrs
    }
    
    var totalWinsOfFBSDefeatedOpponents: Int?
    var totalWinsOfFBSDefeatedOpponentsStr: String {
        if let totalWinsOfFBSDefeatedOpponents = self.totalWinsOfFBSDefeatedOpponents {
            return String(describing: totalWinsOfFBSDefeatedOpponents)
        } else {
            return "n/a"
        }
    }
    
    var fbsLossOpponentIds: [Int]?
    var fbsLossOpponentIdsStr: String {
        var idStrs = ""
        guard let ids = self.fbsLossOpponentIds else { return  "n/a" }
        for id in ids {
            idStrs += "\(id) ,"
        }
        return idStrs
    }
    
    var totalFCSLosses: Int?
    var totalFCSLossesStr: String {
        if let totalFCSLosses = self.totalFCSLosses {
            return String(totalFCSLosses)
        } else {
            return "n/a"
        }
    }
    
    var totalLosesOfFBSLossOpponents: Int?
    var totalLosesOfFBSLossOpponentsStr: String {
        if let totalLosesOfFBSLossOpponents = self.totalLosesOfFBSLossOpponents {
            return String(totalLosesOfFBSLossOpponents)
        } else {
            return "n/a"
        }
    }

    
    var ranking: Int?
    var rankingScore: Int? {
        var score = 0
        if let totalWins = self.totalWins {
            score += totalWins
        }
        if let totalWinsOfFBSDefeatedOpponents = self.totalWinsOfFBSDefeatedOpponents {
            score += totalWinsOfFBSDefeatedOpponents
        }
        if let losses = self.totalLosses {
            score -= losses
        }
        if let totalLosesOfFBSLossOpponents = self.totalLosesOfFBSLossOpponents {
            score -= totalLosesOfFBSLossOpponents
        }
        if let totalFCSLosses = self.totalFCSLosses {
            score -= (totalFCSLosses * Version.shared.throughWeek) 
        }
        return score
    }
    var scoreDifferential: Int?
    
    var recordString: String {
        let tw = self.totalWins ?? 0
        let tl = self.totalLosses ?? 0
        return "\(tw) - \(tl)"
    }
    
    var teamTitle: String {
        var titleStr = ""
        if let rank = self.ranking {
            titleStr = "(\(titleStr)\(rank)) "
        }
        if let name = self.name {
            titleStr = "\(titleStr)\(name)"
        }
        return titleStr
    }
    
    var games: [Game]?
}
