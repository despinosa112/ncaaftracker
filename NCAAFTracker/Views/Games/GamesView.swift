//
//  GamesView.swift
//  NCAAFTracker
//
//  Created by Daniel Espinosa on 10/10/22.
//

import SwiftUI

struct GamesView: View {

    @StateObject private var gamesViewModel = GamesViewModel()

    var body: some View {
        if #available(iOS 15.0, *) {
            NavigationView {
                VStack {
                    Picker("Games Type", selection: $gamesViewModel.sortType) {
                        Text("All").tag(0)
                        Text("Upsets").tag(1)
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    List(){
                        ForEach(gamesViewModel.filteredWeeklyGames){ weeklyGames in
                            Section(header: Text(weeklyGames.idString)) {
                                ForEach(weeklyGames.games ?? [Game]() ){ game in
                                    GameListItem(game: game, displayRecord: false)
                                }
                            }
                        }
                    }
                    .searchable(text: $gamesViewModel.searchText, prompt: "Search By Team")
                    .navigationTitle("Weekly Games")
                    .listStyle(SidebarListStyle())
                }
                .navigationViewStyle(StackNavigationViewStyle())
                }

        } else {
            // Fallback on earlier versions
        }
    }
}

struct GamesView_Previews: PreviewProvider {
    static var previews: some View {
        GamesView()
    }
}
