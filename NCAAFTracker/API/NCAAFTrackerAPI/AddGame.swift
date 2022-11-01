//
//  AddGame.swift
//  NCAAFTracker
//
//  Created by Daniel Espinosa on 10/11/22.
//

import Foundation

extension NCAAFTrackerAPI {
    
    func addGame(game: Game, week: String, completion: @escaping (String?) -> Void){
        do {
            try db.collection("Scores").document(week).collection("Games").addDocument(from: game)
            completion(nil)
        } catch {
            completion("Error: not able to add game")
        }

    }
}
