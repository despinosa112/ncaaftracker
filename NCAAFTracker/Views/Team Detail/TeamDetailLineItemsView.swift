//
//  TeamDetailLineItemsView.swift
//  NCAAFTracker
//
//  Created by Daniel Espinosa on 11/1/22.
//

import SwiftUI

struct TeamDetailLineItemsView: View {
    
    var team: Team

    var body: some View {
        VStack {
            LineItemView(key: "Ranking Score:", value: String(team.rankingScore ?? 0))
            LineItemView(key: "Score Differential:", value: String(team.scoreDifferential ?? 0))
            LineItemView(key: "Strength Of Schedule Score:", value:  String(team.strengthOfScheduleScore ?? 0))
            LineItemView(key: "Strength Of Schedule Rank:", value:  String(team.strengthOfScheduleRank ?? 0))

            //LineItemView(key: "Defeated Opponent Ids:", value: team.fbsDefeatedOpponentIdsString ?? "n/a")
            LineItemView(key: "Total Wins Of FBS Opponents:", value: team.totalWinsOfFBSDefeatedOpponentsStr )
            LineItemView(key: "Total FCS Losses:", value: team.totalFCSLossesStr)
            //LineItemView(key: "FBS Loss Opponent Ids:", value: team.fbsLossOpponentIdsStr)
            LineItemView(key: "Total Losses Of FBS Loss Opponents:", value: team.totalLosesOfFBSLossOpponentsStr)
            LineItemView(key: "Total Points Scored:", value: String(team.totalPointsScored ?? 0))
            LineItemView(key: "Total Points Allowed:", value: String(team.totalPointsAllowed ?? 0))


        }
    }
}

struct TeamDetailLineItemsView_Previews: PreviewProvider {
    static var previews: some View {
        TeamDetailLineItemsView(team: Team.init(id: "1", name: "OhioState", conId: nil, totalWins: nil, totalLosses: nil, fbsDefeatedOpponentIds: nil, totalWinsOfFBSDefeatedOpponents: nil, ranking: nil))
    }
}
