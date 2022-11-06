//
//  GamesFilter.swift
//  NCAAFTracker
//
//  Created by Daniel Espinosa on 10/30/22.
//

import UIKit

class GamesFilter: NSObject {
    
    static func returnUpsets(games: [Game]) -> [Game] {
        
        let upsetGames = games.filter { game in
            let winnerId = game.winnerId ?? 0
            let loserId = game.loserId ?? 0
            
            let winnerRank = DataAPI.shared.getRankingForTeam(id: winnerId)
            let loserRank = DataAPI.shared.getRankingForTeam(id: loserId)
            
            if (winnerId == 0) {
                return true
            } else if (loserId == 0) {
                return false
            } else {
                return winnerRank > loserRank
            }
        }
        
        return upsetGames
    }

}
