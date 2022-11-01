//
//  GetTeamsByConference.swift
//  NCAAFTracker
//
//  Created by Daniel Espinosa on 10/9/22.
//

import Foundation
import FirebaseFirestore


extension NCAAFTrackerAPI {
   
    func getTeamsByConference(conferenceID: Int?, completion: @escaping ([Team]) -> Void){
        
        var ref: Query? = nil
        if conferenceID != nil {
            ref = db.collection("Teams").whereField("conId", isEqualTo: conferenceID!)
        } else {
            ref = db.collection("Teams")
        }
        
        ref?.getDocuments(completion: { (querySnapshot, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            guard let documents = querySnapshot?.documents else { return }
            var fetchedTeams = [Team]()
            for document in documents {
                do {
                    let team = try document.data(as: Team.self)
                    fetchedTeams.append(team)
                }
                catch {
                  print(error)
                }
            }
            
            let sortedTeams = fetchedTeams.sorted { teamA, teamB in
                let teamAInt = Int(teamA.id ?? "0")
                let teamBInt = Int(teamB.id ?? "0")
                return teamAInt! < teamBInt!
            }
            completion(sortedTeams)
        })
    }
}
