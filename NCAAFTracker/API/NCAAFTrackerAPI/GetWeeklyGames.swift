//
//  GetGamesInWeeks.swift
//  NCAAFTracker
//
//  Created by Daniel Espinosa on 10/17/22.
//

import Foundation

extension NCAAFTrackerAPI {
    
    func getWeeklyGames(weekIds: [Int], completion: @escaping([WeeklyGames]) -> Void) {
        var weeklyGamesList = [WeeklyGames]()
        var index = 0
        
        func  fetchAndSetGameByWeek(week: Int) {
            self.getGamesByWeek(week: week) { games in
                var weeklyGames = WeeklyGames()
                weeklyGames.id = week
                weeklyGames.games = games
                weeklyGamesList.append(weeklyGames)
                index += 1
                if (index < weekIds.count) {
                    fetchAndSetGameByWeek(week: weekIds[index])
                } else {
                    completion(weeklyGamesList)
                }
            }
        }
        
        fetchAndSetGameByWeek(week: weekIds[index])
    }
    
}
