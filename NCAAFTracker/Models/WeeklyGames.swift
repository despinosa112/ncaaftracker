//
//  WeeklyGames.swift
//  NCAAFTracker
//
//  Created by Daniel Espinosa on 10/18/22.
//

import Foundation

struct WeeklyGames: Identifiable{
    var id: Int?
    var games: [Game]?
    
    var idString: String {
        return "Week \(id ?? 0)"
    }
}
