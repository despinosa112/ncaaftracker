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
            LineItemView(key: "Ranking Score:", value: String(team.rankingScore ?? 0))
            LineItemView(key: "Score Differential:", value: String(team.scoreDifferential ?? 0))
            LineItemView(key: "Defeated Opponent Ids:", value: team.fbsDefeatedOpponentIdsString ?? "n/a")
            LineItemView(key: "Total Wins Of FBS Opponents:", value: team.totalWinsOfFBSDefeatedOpponentsStr )
            LineItemView(key: "Total FCS Losses:", value: team.totalFCSLossesStr)
            LineItemView(key: "FBS Loss Opponent Ids:", value: team.fbsLossOpponentIdsStr)
            LineItemView(key: "Total Losses Of FBS Loss Opponents:", value: team.totalLosesOfFBSLossOpponentsStr)
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
