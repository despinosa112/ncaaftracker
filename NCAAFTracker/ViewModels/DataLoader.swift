//
//  DataLoader.swift
//  NCAAFTracker
//
//  Created by Daniel Espinosa on 10/17/22.
//

import Foundation

class DataLoader: ObservableObject {
    
    @Published var throughWeek: Int = 8
    
    @Published var formattedConferences = [Conference]() {
        didSet {
            updatedFormattedConferences()
        }
    }
    @Published var formattedTeams = [Team]() {
        didSet {
            updatedFormattedTeams()
        }
    }
    
    @Published var formattedWeeklyGames = [WeeklyGames](){
        didSet {
            updatedFormattedWeeklyGames()
        }
    }
    
    private var conferences =  [Conference](){
        didSet {
            loadTeams()
        }
    }
    
    private var teams =  [Team](){
        didSet {
            loadGames()
        }
    }
    
    private var rankedTeams = [Team]()
    
    private var weeklyGames =  [WeeklyGames]() {
        didSet {
            formatData()
        }
    }
    
    init(){
        reloadConferences()
        addObservers()
    }
    
    func addObservers(){
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(reloadConferences), name: Notification.Name("updatedThroughWeek"), object: nil)
    }
    
    private func formatData(){
        let dataFormatter = DataFormatter()
        dataFormatter.formatData(conferences: self.conferences, teams: self.teams, weeklyGames: self.weeklyGames)
        
        self.formattedTeams = dataFormatter.returnFormattedTeams()
        self.formattedConferences = dataFormatter.returnFormattedConferences()
        self.formattedWeeklyGames = dataFormatter.returnFormattedWeeklyGames()
        
        DataAPI.shared.add(teams: formattedTeams)
        DataAPI.shared.add(weeklyGames: formattedWeeklyGames)
        DataAPI.shared.add(conferences: formattedConferences)

    }
    
    @objc private func reloadConferences(){
        NCAAFTrackerAPI.shared.getConferences { conferences in
            self.conferences = conferences
        }
    }
    
    private func loadTeams(){
        NCAAFTrackerAPI.shared.getTeamsByConference(conferenceID: nil) { teams in
            self.teams = teams
        }
    }
    
    private func loadGames(){
        NCAAFTrackerAPI.shared.getWeeklyGames(weekIds: Array(1...Version.shared.throughWeek)) { weeklyGames in
                self.weeklyGames = weeklyGames
            }
    }
    
    func updatedFormattedConferences(){
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("updatedFormattedConferences"), object: self.formattedConferences)
    }
    
    func updatedFormattedTeams(){
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("updatedFormattedTeams"), object: self.formattedTeams)
    }
    
    func updatedFormattedWeeklyGames(){
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("updatedFormattedWeeklyGames"), object: self.formattedWeeklyGames)
    }
    
}

