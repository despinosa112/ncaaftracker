//
//  GameView.swift
//  NCAAFTracker
//
//  Created by Daniel Espinosa on 10/18/22.
//

import SwiftUI

struct GameListItem: View {
    
    var game: Game
    var displayRecord: Bool
    
    @EnvironmentObject var dataLoader: DataLoader

    var body: some View {
        VStack {
            HStack {
                Text(String(describing: "\(DataAPI.shared.getRankingStringForTeam(id: game.winnerId)).")).bold()
                Text(game.winnerName ?? "FCS TEAM").bold()
                Text(String(game.winnerScore ?? 0)).bold()
                Spacer()
                if (displayRecord) {
                    Text(DataAPI.shared.getRecordStringForTeam(id: String(game.winnerId!))).bold()
                }
            }
            HStack {
                Text(String(describing: "\(DataAPI.shared.getRankingStringForTeam(id: game.loserId))."))
                Text(game.loserName ?? "FCS TEAM")
                Text(String(game.loserScore ?? 0))
                Spacer()
                if (displayRecord) {
                    Text(DataAPI.shared.getRecordStringForTeam(id: String(game.loserId!))).bold()
                }


            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameListItem(game: Game(id: nil, a: nil, aScore: nil, b: nil, bScore: nil, aName: nil, bName: nil, winnerName: nil, loserName: nil), displayRecord: true)
    }
}
