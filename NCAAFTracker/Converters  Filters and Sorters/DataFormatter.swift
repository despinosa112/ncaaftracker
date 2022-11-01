//
//  DataFormatter.swift
//  NCAAFTracker
//
//  Created by Daniel Espinosa on 10/18/22.
//

import Foundation

class DataFormatter: NSObject {
        
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
        let formattedTeams = returnTeamsWithStengthOfScheduleRank(teams: returnTeamsWithStengthOfScheduleScore(teams: Ranker.init(teams: teamsWithGames, weeklyGames: formattedWeeklyGames).returnRankedTeams()))
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

extension DataFormatter {
    //Functions for strength of schedule
    private func returnTeamsWithStengthOfScheduleScore(teams: [Team]) -> [Team]{
        var teamsWithScheduleScore = [Team]()
        for team in teams {
            var teamWithScheduleScore = team
            if let games = team.games {
                var strengthOfScheduleScore = 0
                for game in games {
                    let opponentId = Int(team.id!)! == game.a! ?  game.b! : game.a!
                    let opponentRanking = getRankingFromId(id: opponentId, teams: teams)
                    let rankingValue = rankingValue(teamsCount: teams.count, ranking: opponentRanking)
                    strengthOfScheduleScore += rankingValue
                }
                teamWithScheduleScore.strengthOfScheduleScore = strengthOfScheduleScore
            }
            teamsWithScheduleScore.append(teamWithScheduleScore)
        }
        
        return teamsWithScheduleScore
    }
    
    private func rankingValue(teamsCount: Int, ranking: Int) -> Int {
        return (teamsCount + 2) - ranking
    }
    
    
    private func getRankingFromId(id: Int, teams: [Team]) -> Int {
        let totalTeamsCount = teams.count

        //FCS Schools should always be a totalTeamsCount plus 1 indicating it is one point worse than the last FBS team
        if (id == 0){
            return totalTeamsCount + 1
        }
        
        for team in teams {
            if (Int(team.id!)! == id) {
                return team.ranking!
            }
        }
        
        //Edge case, should always return a a ranking
        return totalTeamsCount + 1
        
    }

    private func returnTeamsWithStengthOfScheduleRank(teams: [Team]) -> [Team] {
        let teamsSortedByStrengthOfScheduleScore = teams.sorted { teamA, teamB in
            return teamA.strengthOfScheduleScore! > teamB.strengthOfScheduleScore!
        }
        
        var teamsWithStrengthOfScheduleRank = [Team]()
        
        var strengthOfScheduleRank = 1
        
        for team in teamsSortedByStrengthOfScheduleScore {
            var teamWithStrengthOfScheduleRank = team
            teamWithStrengthOfScheduleRank.strengthOfScheduleRank = strengthOfScheduleRank
            strengthOfScheduleRank += 1
            teamsWithStrengthOfScheduleRank.append(teamWithStrengthOfScheduleRank)
        }
        return teamsWithStrengthOfScheduleRank
    }
}
