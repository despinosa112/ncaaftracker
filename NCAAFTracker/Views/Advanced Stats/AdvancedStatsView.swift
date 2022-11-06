//
//  AdvancedStatsView.swift
//  NCAAFTracker
//
//  Created by Daniel Espinosa on 11/3/22.
//

import SwiftUI

struct AdvancedStatsView: View {
    

    @StateObject var advancedStatsViewModel: AdvancedStatsViewModel

    var body: some View {
        if #available(iOS 15.0, *) {
            NavigationView(){
                VStack {
                    Picker("Sort Type", selection: $advancedStatsViewModel.sortType) {
                        Text("Strength Of Schedule").tag(2)
                        Text("PPG Scored").tag(3)
                        Text("PPG Allowed").tag(4)
                        Text("Score +-").tag(5)

                    }
                    .pickerStyle(.segmented)
                    .padding()
                    
                    List() {
                        Section(header: Text(String("Through week \(Version.shared.throughWeek)"))) {
                            ForEach(advancedStatsViewModel.filteredTeams){ team in
                                NavigationLink {
                                    TeamDetailView(team: team)
                                } label: {
                                    VStack {
                                        HStack {
                                            //Text(String(team.strengthOfScheduleRank ?? 0)).bold()
                                            Text(String(team.ranking ?? 0)).bold()
                                            Text(". ").bold()
                                            Text(team.name ?? "UNKNOWN").bold()
                                            //Text(String(team.strengthOfScheduleScore ?? 0)).fontWeight(.light)
                                            Text(team.advancedStatValue(sortType: advancedStatsViewModel.sortType)).fontWeight(.light)
                                            Spacer()
                                        }
                                    }.frame(height: 50)
                                }
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                    .searchable(text: $advancedStatsViewModel.searchQuery, prompt: "Search By Team")
                    .navigationTitle("Advanced Stats")
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
}

struct AdvancedStatsView_Previews: PreviewProvider {
    static var previews: some View {
        AdvancedStatsView(advancedStatsViewModel: AdvancedStatsViewModel())
    }
}
