//
//  RankerViewModel.swift
//  NCAAFTracker
//
//  Created by Daniel Espinosa on 10/12/22.
//

import Foundation
import Combine

class RankerViewModel: ObservableObject {
    
    var rankedTeams = [Team]() {
        didSet {
            filterTeams()
        }
    }
    
    @Published var sortType = 0 {
        didSet {
            filterTeams()
        }
    }
    
    @Published var filteredRankTeams = [Team]()
    
    @Published var searchQuery = "" {
        didSet {
            filterTeams()
        }
    }
    
    //TODO: turn this into combine
    init(dataLoader: DataLoader){
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(updatedFormattedTeams(_:)), name: Notification.Name("updatedFormattedTeams"), object: nil)
    }
    
    @objc func updatedFormattedTeams(_ notification: Notification){
        guard let rankedTeams = notification.object as? [Team] else { return }
        self.rankedTeams = rankedTeams
    }
        
    func filterTeams(){
        let teams = TeamsFilter.filterTeams(teams: rankedTeams, query: searchQuery)
        self.filteredRankTeams = TeamsSorter.sortTeamsByRanking(teams: teams, sortType: sortType)        
    }
}
