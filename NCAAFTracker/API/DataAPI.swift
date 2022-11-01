//
//  DataAPI.swift
//  NCAAFTracker
//
//  Created by Daniel Espinosa on 10/30/22.
//

import UIKit

class DataAPI: NSObject {
    
    private var weeklyGames = [WeeklyGames]()
    private var teams = [Team]()
    private var conferences = [Conference]()
    
    static let shared = DataAPI()
    

    func add(weeklyGames: [WeeklyGames]){
        self.weeklyGames = weeklyGames
    }
    
    func add(teams: [Team]){
        self.teams = teams
    }
    
    func add(conferences: [Conference]){
        self.conferences = conferences
    }
    
    
    func getWeeklyGames() -> [WeeklyGames] {
        return self.weeklyGames
    }
    
    func getWeeklyGamesUpsets() -> [WeeklyGames] {
        let allWeeklyGames = self.weeklyGames
        
        var weeklyGamesUpsets = [WeeklyGames]()
        for weeklyGames in allWeeklyGames {
            var weeklyGames = weeklyGames
            weeklyGames.games = GamesFilter.returnUpsets(games: weeklyGames.games ?? [Game]())
            weeklyGamesUpsets.append(weeklyGames)
        }
        print("-de-weeklyGamesUpsets : \(weeklyGamesUpsets)")
        return weeklyGamesUpsets
    }
    
    
    func getRecordStringForTeam(id: String) -> String {
        guard let team = teams.first(where: {$0.id == id}) else { return ""}
        return team.recordString
    }
    
    func getRankingForTeam(id: Int?) -> Int {
        guard let id = id else { return 0}
        let idString = String(describing: id)
        guard let team = teams.first(where: {$0.id == idString}) else { return 0}
        return team.ranking ?? 0
    }
    
    func getRankingStringForTeam(id: Int?) -> String {
        guard let id = id else { return "NR"}
        let idString = String(describing: id)
        guard let team = teams.first(where: {$0.id == idString}) else { return "NR"}
        return team.ranking != nil ? "\(team.ranking!)" : "NR"
    }
    
    

}
