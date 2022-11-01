//
//  GetGames.swift
//  NCAAFTracker
//
//  Created by Daniel Espinosa on 10/9/22.
//

import Foundation
import FirebaseFirestore


extension NCAAFTrackerAPI {
   
    func getGamesByWeek(week: Int, completion: @escaping ([Game]) -> Void){
        
        var ref: Query = db.collection("Scores").document("\(week)").collection("Games")

        ref.getDocuments(completion: { (querySnapshot, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            guard let documents = querySnapshot?.documents else { return }
            var fetchedGames = [Game]()
            for document in documents {
                do {
                    let game = try document.data(as: Game.self)
                    fetchedGames.append(game)
                }
                catch {
                  print(error)
                }
            }
            completion(fetchedGames)
        })
    }
    
}
