//
//  DataFormatter.swift
//  NCAAFTracker
//
//  Created by Daniel Espinosa on 10/18/22.
//

import Foundation

class DataFormatter: NSObject {
    
    //static let shared = DataFormatter()
    
    var formattedTeams: [Team]!
    var formattedWeeklyGames: [WeeklyGames]!
    var formattedConferences: [Conference]!

    
    public func returnFormattedTeams() -> [Team]{
        return self.formattedTeams
    }
    
    public func returnFormattedWeeklyGames() -> [WeeklyGames]{
        return self.formattedWeeklyGames
    }
    
    public func returnFormattedConferences() -> [Conference]{
        return self.formattedConferences
    }

    
    public func formatData(conferences: [Conference], teams: [Team], weeklyGames: [WeeklyGames]){
        let formattedWeeklyGames = self.returnMappedWeeklyGames(teams: teams, weeklyGames: weeklyGames)
        let teamsWithGames = self.returnTeamsWithGames(teams: teams, weeklyGames: formattedWeeklyGames)
        let formattedTeams = Ranker.init(teams: teamsWithGames, weeklyGames: formattedWeeklyGames).returnRankedTeams()
        let formattedConferences = ConferenceConverter.addTeamsToConference(conferences: conferences, teams: formattedTeams)

        self.formattedTeams = formattedTeams
        self.formattedWeeklyGames = formattedWeeklyGames
        self.formattedConferences =  formattedConferences

    }
    


    
    
    private func returnMappedWeeklyGames(teams: [Team], weeklyGames: [WeeklyGames]) -> [WeeklyGames]{
        var mappedWeeklyGamesList = [WeeklyGames]()
        for weeklyGamesItem in weeklyGames {
            var weeklyGames = weeklyGamesItem
            weeklyGames.games = GamesConverter.mapGames(games: weeklyGames.games ?? [Game](), teams: teams)
            mappedWeeklyGamesList.append(weeklyGames)
        }
        return mappedWeeklyGamesList
    }
    
    
    
    private func returnTeamsWithGames(teams: [Team], weeklyGames: [WeeklyGames]) -> [Team] {
        let gamesArr = GamesConverter.convertToGamesArray(weeklyGames: weeklyGames)
        var teamsToReturn = [Team]()
        
        for team in teams {
            var teamWithGames = team
            teamWithGames.games = returnFilteredGamesThatIncludeTeam(team: team, games: gamesArr)
            teamsToReturn.append(teamWithGames)
        }
        return teamsToReturn
    }
    
    private func returnFilteredGamesThatIncludeTeam(team: Team, games: [Game]) -> [Game]{
        guard let teamId = team.id else { return [Game]() }
        let filteredGames = games.filter { game in
            if let a = game.a{
                if (String(a) == teamId)  {
                    return true
                }
            }
            if let b = game.b{
                if (String(b) == teamId)  {
                    return true
                }
            }
            return false
        }
        return filteredGames
    }
    
    
}