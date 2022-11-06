//
//  AdvancedStatsViewModel.swift
//  NCAAFTracker
//
//  Created by Daniel Espinosa on 11/3/22.
//

import Foundation

class AdvancedStatsViewModel: ObservableObject {
    
    var formattedTeams = [Team]() {
        didSet {
            filterTeams()
        }
    }
    
    @Published var sortType = 2 {
        didSet {
            filterTeams()
        }
    }
    
    @Published var filteredTeams = [Team]()
    
    @Published var searchQuery = "" {
        didSet {
            filterTeams()
        }
    }
    
    //TODO: turn this into combine
    init(){
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(updatedFormattedTeams(_:)), name: Notification.Name("updatedFormattedTeams"), object: nil)
    }
    
    @objc func updatedFormattedTeams(_ notification: Notification){
        guard let formattedTeams = notification.object as? [Team] else { return }
        self.formattedTeams = formattedTeams
    }
        
    func filterTeams(){
        let teams = TeamsFilter.filterTeams(teams: formattedTeams, query: searchQuery)
        self.filteredTeams = TeamsSorter.sortTeamsByRanking(teams: teams, sortType: sortType)
    }
}
