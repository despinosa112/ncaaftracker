//
//  GamesConverter.swift
//  NCAAFTracker
//
//  Created by Daniel Espinosa on 10/17/22.
//

import Foundation

class GamesConverter: NSObject {
    
    static func convertToGamesArray(weeklyGames: [WeeklyGames]) -> [Game] {
        var gamesToReturn = [Game]()
        for weeklyGamesItem in weeklyGames {
            if let games = weeklyGamesItem.games {
                gamesToReturn.append(contentsOf: games)
            }
        }
        return gamesToReturn
    }
    
    static func mapGames(games: [Game], teams: [Team]) -> [Game] {
        var mappedGames = [Game]()
        for game in games {
            var mappedGame = game
            
            var aName = ""
            var bName = ""

            if let a = game.a { aName = teamNameBy(teamId: a, teams: teams) }
            if let b = game.b { bName = teamNameBy(teamId: b, teams: teams) }

            mappedGame.aName = aName
            mappedGame.bName = bName
            
            if let a = game.a { aName = teamNameBy(teamId: a, teams: teams) }
            if let b = game.b { bName = teamNameBy(teamId: b, teams: teams) }
            
            //Setting Names
            mappedGame.aName = aName
            mappedGame.bName = bName
            
            mappedGame.winnerName = mappedGame.winnerId == game.a ? aName : bName
            mappedGame.loserName = mappedGame.loserId == game.a ? aName : bName

            mappedGames.append(mappedGame)
        }
        return mappedGames
    }
    
    static func teamNameBy(teamId: Int, teams: [Team]) -> String {
        if (teamId == 0){
            return "FCS Team"
        }
        let team = teams.first { team in
            if (team.id == nil) {
                return false
            }
            return team.id == String(teamId)
        }
        return team?.name ?? "FCS Team"
    }

}
