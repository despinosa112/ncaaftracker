//
//  ConferenceConverter.swift
//  NCAAFTracker
//
//  Created by Daniel Espinosa on 10/18/22.
//

import Foundation
class ConferenceConverter: NSObject {
    
    static func addTeamsToConference(conferences: [Conference], teams: [Team]) -> [Conference] {
        var conferencesWithTeams = [Conference]()
        for conference in conferences {
            var conferenceWithTeams = conference
            let teamsInConference = teams.filter { team in
                return String(team.conId ?? 0) == conference.id
            }
            conferenceWithTeams.teams = teamsInConference.count > 0 ? teamsInConference : [Team]()
            if (conferenceWithTeams.id != "0"){
                conferencesWithTeams.append(conferenceWithTeams)
            }
        }
        return conferencesWithTeams
    }
    
}

