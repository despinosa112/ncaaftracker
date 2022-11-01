//
//  AddGameViewModel.swift
//  NCAAFTracker
//
//  Created by Daniel Espinosa on 10/10/22.
//

import Foundation
import Combine

class AddGameViewModel: ObservableObject {
    
    @Published var aTeam: Team?
    @Published var aScore = ""
    @Published var bTeam: Team?
    @Published var bScore = ""
    
    @Published var inlineError = ""

    
    func clearData(){
        aTeam = nil
        aScore = ""
        bTeam = nil
        bScore = ""
    }
    
    init(){
        addObservers()
    }
    
    deinit {
        removeNotifications()
    }
    
    func addObservers(){
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(self.selectedTeam(notification:)), name: Notification.Name.selectedTeam, object: nil)
    }
    
    func removeNotifications(){
        let nc = NotificationCenter.default
        nc.removeObserver(self, name: NSNotification.Name.selectedTeam, object: nil)
    }

    @objc func selectedTeam(notification: Notification){
        guard let selectedTeam = notification.object as? Team else { return }
        guard let userInfo = notification.userInfo else { return }
        guard let selectorId = userInfo["selectorId"] as? String else { return }

        switch selectorId {
        case "A":
            self.aTeam = selectedTeam
        case "B":
            self.bTeam = selectedTeam
        default:
            print("error: unknown selectorId")
        }
    }
    
    func addGame(){
        guard let a = self.aTeam?.id, let b = self.bTeam?.id  else {
            self.inlineError = "Error: Unable to validate data"
            return
        }
        guard let aInt = Int(a), let bInt = Int(b)  else {
            self.inlineError = "Error: Unable to validate data"
            return
        }
        guard let aScore = Int(self.aScore), let bScore = Int(self.bScore)  else {
            self.inlineError = "Error: Unable to validate data"
            return
        }
        let game = Game(id: nil,
                        a: aInt,
                        aScore: aScore,
                        b: bInt,
                        bScore: bScore,
                        aName: nil,
                        bName: nil,
                        winnerName: nil,
                        loserName: nil)
        NCAAFTrackerAPI.shared.addGame(game: game, week: String(Version.shared.throughWeek)) { err in
            if (err != nil) {
                self.inlineError = err!
                return
            }
            self.clearData()
            self.inlineError = "Successfully Added Game"
        }
    }
}
