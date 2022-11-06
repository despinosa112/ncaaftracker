//
//  ContentView.swift
//  NCAAFTracker
//
//  Created by Daniel Espinosa on 10/3/22.
//

import SwiftUI
import FirebaseFirestore
import FirebaseCore
import Firebase
import Combine

struct ContentView: View {

    @EnvironmentObject var dataLoader: DataLoader

    var body: some View {
        TabView {
            RankerView(rankerViewModel: RankerViewModel(dataLoader: dataLoader))
                .tabItem {
                    Label("Rankings", systemImage: "list.dash")
                }
            ConferencesView()
                .tabItem {
                    Label("Conferences", systemImage: "list.dash")
                }
            GamesView()
                .tabItem {
                    Label("Games", systemImage: "square.and.pencil")
                }
            AdvancedStatsView(advancedStatsViewModel: AdvancedStatsViewModel())
                .tabItem {
                    Label("Advanced Stats", systemImage: "square.and.pencil")
                }
            AddGameView()
                .tabItem {
                    Label("Add Game", systemImage: "square.and.pencil")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
