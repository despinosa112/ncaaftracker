//
//  ConferencesViewModel.swift
//  NCAAFTracker
//
//  Created by Daniel Espinosa on 10/9/22.
//

import Foundation

class ConferencesViewModel: ObservableObject {
    

    private var conferences: [Conference]! {
        didSet {
            filterTeams()
        }
    }
    
    @Published var searchText = "" {
        didSet {
            filterTeams()
        }
    }
    
    @Published var filteredConferences = [Conference]()
    @Published var sortType = 0 {
        didSet {
            self.filterTeams()
        }
    }

    
    init(){
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(updatedFormattedConferences(_:)), name: Notification.Name("updatedFormattedConferences"), object: nil)
    }
    
    @objc func updatedFormattedConferences(_ notification: Notification){
        guard let conferences = notification.object as? [Conference] else { return }
        self.conferences = conferences
    }
    
    func filterTeams(){
        guard let conferences = self.conferences else { return }
        var filteredConferences = [Conference]()
        for conference in conferences {
            guard let conferenceTeams = conference.teams else { return }
            
            let filteredTeams = TeamsFilter.filterTeams(teams: conferenceTeams, query: searchText)
                        
            var sortedFilteredTeams = [Team]()
            switch sortType {
            case 0:
                sortedFilteredTeams = TeamsSorter.sortTeamsById(teams: filteredTeams)
            case 1:
                sortedFilteredTeams = TeamsSorter.sortTeamsByRanking(teams: filteredTeams)
            case 2:
                sortedFilteredTeams = TeamsSorter.sortTeamsByAZ(teams: filteredTeams)
            default:
                sortedFilteredTeams = TeamsSorter.sortTeamsById(teams: filteredTeams)
            }
            
            if (filteredTeams.count > 0){
                var filteredConference = conference
                filteredConference.teams = sortedFilteredTeams
                filteredConferences.append(filteredConference)
            }
        }
        self.filteredConferences = filteredConferences
    }
    
}
