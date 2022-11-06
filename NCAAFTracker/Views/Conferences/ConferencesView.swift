//
//  ConferencesView.swift
//  NCAAFTracker
//
//  Created by Daniel Espinosa on 10/9/22.
//

import SwiftUI

struct ConferencesView: View {
    
    @StateObject private var conferencesViewModel = ConferencesViewModel()
    
    var body: some View {
        if #available(iOS 15.0, *) {
            NavigationView {
                VStack {
                    Picker("Sort Type", selection: $conferencesViewModel.sortType) {
                        Text("Id").tag(0)
                        Text("Ranking").tag(1)
                        Text("A-Z").tag(2)
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    List(){
                        ForEach(conferencesViewModel.filteredConferences){ conference in
                            Section(header: Text(conference.name ?? "UNKNOWN")) {
                                ForEach(conference.teams ?? [Team]()){ team in
                                    NavigationLink {
                                        TeamDetailView(team: team)
                                    } label: {
                                        HStack {
                                            Text(team.id ?? "")
                                            Text(team.name ?? "UNKNOWN")
                                            Spacer()
                                            Text(String(team.ranking ?? 0))
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .searchable(text: $conferencesViewModel.searchText, prompt: "Find a Team")
                    .navigationTitle("All Teams")
                    .listStyle(SidebarListStyle())
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())

        } else {
            // Fallback on earlier versions
        }
    }
}

struct ConferencesView_Previews: PreviewProvider {
    static var previews: some View {
        ConferencesView()
    }
}
