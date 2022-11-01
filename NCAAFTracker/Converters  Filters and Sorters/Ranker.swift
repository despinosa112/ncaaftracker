//
//  Ranker.swift
//  NCAAFTracker
//
//  Created by Daniel Espinosa on 10/19/22.
//

import Foundation

class Ranker: NSObject {
    
    var rankedTeams: [Team]!
    
    init(teams: [Team], weeklyGames: [WeeklyGames]) {
        
        let games = GamesConverter.convertToGamesArray(weeklyGames: weeklyGames)
        let teamsMap = Ranker.returnTeamsMappedWithBaseRankingData(teams: teams)
        let rankedTeams = Ranker.returnCalculatedRankings(games: games, teamsMap: teamsMap)
        self.rankedTeams = rankedTeams
        
    }
    
    func returnRankedTeams() -> [Team] {
        return self.rankedTeams
    }
    
    
    static func returnCalculatedRankings(games: [Game], teamsMap: [Int: Team]) -> [Team] {
        let teamsMapWithRankingData =  Ranker.returnTeamsMapWithRankingData(games: games, teamsMap: teamsMap)
        let teamsArrayWithRankingData = Ranker.returnRankedTeamsArrayFromTeamsMap(teamsMap: teamsMapWithRankingData)
        let teamsArrWithTotalWinsOfFBSDefeatedOpponents =  Ranker.returnTeamsWithTotalWinsOfFBSDefeatedOpponents(teamsWithFbsDefeatedOpponentIds: teamsArrayWithRankingData, teamsMap: teamsMapWithRankingData)
        
        
        //Include Losses
        let teamsArrWithTotalLossesOfFBSLossOpponents = Ranker.returnTeamsWithTotalLossesOfFBSLossOpponents(teams: teamsArrWithTotalWinsOfFBSDefeatedOpponents, teamsMap: teamsMapWithRankingData)
        let teamsWithRankingDataSortedFirstToLast = Ranker.returnSortedTeamsByRankingScore(teams: teamsArrWithTotalLossesOfFBSLossOpponents)
        
        //Dont Include losses
        //let teamsWithRankingDataSortedFirstToLast = Ranker.returnSortedTeamsByRankingScore(teams: teamsArrWithTotalWinsOfFBSDefeatedOpponents)
        
        
        
        let rankedteams = Ranker.returnTeamsWithRankingFromSortedRankedTeamsFirstToLast(teams: teamsWithRankingDataSortedFirstToLast)
        return rankedteams
    }
    
    static private func returnTeamsMappedWithBaseRankingData(teams: [Team]) -> [Int: Team]{
        var teamsMap = [Int: Team]()
        
        for team in teams {
            if let teamId = Int(team.id ?? "ERROR") {
                var teamWith00Record = team
                teamWith00Record.totalWins = 0
                teamWith00Record.totalLosses = 0
                teamWith00Record.scoreDifferential = 0
                teamWith00Record.fbsDefeatedOpponentIds = [Int]()
                teamWith00Record.totalWinsOfFBSDefeatedOpponents = 0
                teamWith00Record.totalFCSLosses = 0
                teamWith00Record.fbsLossOpponentIds = [Int]()
                teamWith00Record.totalLosesOfFBSLossOpponents = 0
                teamsMap[teamId] = teamWith00Record
            }
        }
        return teamsMap
    }

    
    static private func returnTeamsMapWithRankingData(games: [Game], teamsMap: [Int: Team]) -> [Int: Team]{
        var mutatingTeamsMap = teamsMap
        for game in games {
            let scoreDifference = game.scoreDifference
            

            if let winnerId = game.winnerId, let loserId = game.loserId {
                mutatingTeamsMap[winnerId]?.totalWins! += 1
                mutatingTeamsMap[winnerId]?.scoreDifferential! += scoreDifference ?? 0
                if( loserId != 0){
                    mutatingTeamsMap[winnerId]?.fbsDefeatedOpponentIds?.append(loserId)
                }
                if (winnerId == 0){
                    mutatingTeamsMap[loserId]?.totalFCSLosses! += 1
                    
                }
                if (loserId != 0 && winnerId != 0){
                    mutatingTeamsMap[loserId]?.fbsLossOpponentIds?.append(winnerId)
                }
                
                
                mutatingTeamsMap[loserId]?.totalLosses! += 1
                mutatingTeamsMap[loserId]?.scoreDifferential! -= scoreDifference ?? 0
                
                
            }
        }
        
        return mutatingTeamsMap
    }
    
    static private func returnRankedTeamsArrayFromTeamsMap(teamsMap: [Int: Team]) -> [Team] {
        var teams = [Team]()
        for (teamId, team) in teamsMap {
            if (teamId != 0) {
                teams.append(team)
            }
        }
        return teams
    }
    
    static private func returnSortedTeamsByRankingScore(teams: [Team]) -> [Team] {
        let sortedTeams = teams.sorted { ltm, rtm in
            
            let lrs = ltm.rankingScore ?? 0
            let rrs = rtm.rankingScore ?? 0
            
            let lsd = ltm.scoreDifferential ?? 0
            let rsd = rtm.scoreDifferential ?? 0
            
            if (lrs == rrs) {
                return lsd > rsd
            } else {
                return lrs > rrs
            }
        }
        return sortedTeams
    }
    
    static private func returnTeamsWithRankingFromSortedRankedTeamsFirstToLast(teams: [Team]) -> [Team]{
        var rankedTeams = [Team]()
        var index = 1
        for team in teams {
            var rankedTeam = team
            rankedTeam.ranking = index
            rankedTeams.append(rankedTeam)
            index += 1
        }
        return rankedTeams
    }
    
    static private func returnTeamsWithTotalWinsOfFBSDefeatedOpponents(teamsWithFbsDefeatedOpponentIds: [Team], teamsMap: [Int: Team]) -> [Team] {
        var teamsToReturn = [Team]()
        for team in teamsWithFbsDefeatedOpponentIds {
            var teamToReturn = team
            if let fbsDefeatedOpponentIds = team.fbsDefeatedOpponentIds {
                for defeatedTeamId in fbsDefeatedOpponentIds {
                    if let defeatedTeam = teamsMap[defeatedTeamId] {
                        if let defeatedTeamTotalWins = defeatedTeam.totalWins {
                            if (teamToReturn.totalWinsOfFBSDefeatedOpponents != nil) {
                                teamToReturn.totalWinsOfFBSDefeatedOpponents! += defeatedTeamTotalWins
                            }
                        }
                    }
                }
            }
            teamsToReturn.append(teamToReturn)
        }
        return teamsToReturn
    }
    
    static private func returnTeamsWithTotalLossesOfFBSLossOpponents(teams: [Team], teamsMap: [Int: Team]) -> [Team] {
        var teamsToReturn = [Team]()
        for team in teams {
            var teamToReturn = team
            if let fbsLossOpponentIds = team.fbsLossOpponentIds {
                for lossTeamId in fbsLossOpponentIds {
                    if (lossTeamId == 0){
                        //lost to a fcs team
                        if (teamToReturn.totalFCSLosses != nil) {
                            teamToReturn.totalFCSLosses! += 1 
                        }
                    } else {
                        //lost to a fbs team
                        if let lossTeam = teamsMap[lossTeamId] {
                            if let lossTeamTotalFCSLosses = lossTeam.totalFCSLosses {
                                if (teamToReturn.totalLosses != nil) {
                                    teamToReturn.totalLosesOfFBSLossOpponents! += lossTeam.totalLosses!
                                }
                            }
                        }
                    }
                }
            }
            teamsToReturn.append(teamToReturn)
        }
        return teamsToReturn
    }
}
