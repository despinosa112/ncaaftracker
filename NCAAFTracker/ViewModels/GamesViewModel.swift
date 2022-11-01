//
//  GamesViewModel.swift
//  NCAAFTracker
//
//  Created by Daniel Espinosa on 10/9/22.
//

import Foundation

class GamesViewModel: ObservableObject {
    
    private var weeklyGames = [WeeklyGames]() {
        didSet {
            self.filterGamesByTeam()
        }
    }
    
    
    
    @Published var filteredWeeklyGames = [WeeklyGames]()

    @Published var searchText = "" {
        didSet {
            self.filterGamesByTeam()
        }
    }
    
    @Published var sortType = 0 {
        didSet {
            if (sortType == 0){
                weeklyGames = DataAPI.shared.getWeeklyGames()
            } else {
                let weeklyGamesUpsets = DataAPI.shared.getWeeklyGamesUpsets()
                weeklyGames = weeklyGamesUpsets
            }
        }
    }
    
    init(){
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(updatedFormattedWeeklyGames(_:)), name: Notification.Name("updatedFormattedWeeklyGames"), object: nil)
    }
    
    @objc func updatedFormattedWeeklyGames(_ notification: Notification){
        guard let weeklyGames = notification.object as? [WeeklyGames] else { return }
        self.weeklyGames = weeklyGames
    }
    
    func filterGamesByTeam() {
        if (searchText == ""){
            self.filteredWeeklyGames = weeklyGames
            return
        }        
        var filteredWeeklyGames = [WeeklyGames]()
        
        for weeklyGamesItem in self.weeklyGames {
            var filteredWeeklyGamesItem = weeklyGamesItem
            filteredWeeklyGamesItem.games = self.returnFilteredGamesByTeamName(teamQuery: searchText, games: weeklyGamesItem.games ?? [Game]())
            if (filteredWeeklyGamesItem.games?.count ?? 0 > 0) {
                filteredWeeklyGames.append(filteredWeeklyGamesItem)
            }
        }
        self.filteredWeeklyGames = filteredWeeklyGames
    }
    
    func returnFilteredGamesByTeamName(teamQuery: String, games: [Game]) -> [Game] {

        if (teamQuery == ""){
            return games
        }

        var filteredGames = [Game]()

        for game in games {
            var shouldInclude = false

            if let aName = game.aName {
                if aName.lowercased().contains(searchText.lowercased()){
                    shouldInclude = true
                }
            }
            if let bName = game.bName {
                if bName.lowercased().contains(searchText.lowercased()){
                    shouldInclude = true
                }
            }
            if (shouldInclude == true){
                filteredGames.append(game)
            }
        }
        return filteredGames
    }
    
}
