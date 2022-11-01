//
//  GetConferences.swift
//  NCAAFTracker
//
//  Created by Daniel Espinosa on 10/9/22.
//

import Foundation
import FirebaseFirestore


extension NCAAFTrackerAPI {
   
    func getConferences(completion: @escaping ([Conference]) -> Void){
        db.collection("Conference").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            guard let documents = querySnapshot?.documents else { return }
            var fetchedConferences = [Conference]()
            for document in documents {
                do {
                    let conference = try document.data(as: Conference.self)
                    fetchedConferences.append(conference)
                }
                catch {
                  print(error)
                }
            }
            let sortedConferences = fetchedConferences.sorted { conferenceA, conferenceB in
                let conferenceAInt = Int(conferenceA.id ?? "0")
                let conferenceBInt = Int(conferenceB.id ?? "0")
                return conferenceAInt! < conferenceBInt!
            }
            completion(sortedConferences)
        }
    }
}
