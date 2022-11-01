//
//  TeamDetailView.swift
//  NCAAFTracker
//
//  Created by Daniel Espinosa on 10/18/22.
//

import SwiftUI

struct TeamDetailView: View {
    
    var team: Team
    
    var body: some View {
        VStack {
            Text(team.teamTitle)
                .bold()
            Text(team.recordString)
            TeamDetailLineItemsView(team: team)
            List(){
                Section(header: Text("Games")) {
                    ForEach(team.games ?? [Game]()) { game in
                        GameListItem(game: game, displayRecord: true)
                    }
                }
            }
        }
    }
}

struct TeamDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TeamDetailView(team: Team.init(id: "1", name: "OhioState", conId: nil, totalWins: nil, totalLosses: nil, fbsDefeatedOpponentIds: nil, totalWinsOfFBSDefeatedOpponents: nil, ranking: nil, scoreDifferential: nil))
    }
}
