//
//  AutoCompleteTeamViewModel.swift
//  NCAAFTracker
//
//  Created by Daniel Espinosa on 10/11/22.
//

import Foundation
import Combine

class AutoCompleteTeamViewModel: ObservableObject {
        
    @Published var searchText = "" {
        didSet {
            filterTeams()
        }
    }
    
    @Published var filteredTeams = [Team]()
    
    @Published var teams = [Team]() {
        didSet {
            self.filterTeams()
        }
    }
    
    var selectorId: String = "A"
    
    init() {
        fetchTeams()
    }
    
    init(selectorId: String){
        self.selectorId = selectorId
        fetchTeams()
    }
    
    func fetchTeams(){
        NCAAFTrackerAPI.shared.getTeamsByConference(conferenceID: nil, completion: { teams in
            self.teams = teams
        })
    }
    
    func filterTeams(){
        self.filteredTeams = TeamsFilter.filterTeams(teams: self.teams, query: searchText, shouldIncludeFCSTeam: true)
    }
    
    func selectTeam(team: Team){
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name.selectedTeam, object: team, userInfo: ["selectorId": selectorId])
    }
}
