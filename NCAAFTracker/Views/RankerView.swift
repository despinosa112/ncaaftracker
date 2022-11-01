//
//  RankerView.swift
//  NCAAFTracker
//
//  Created by Daniel Espinosa on 10/12/22.
//

import SwiftUI

struct RankerView: View {
    
    @StateObject var rankerViewModel: RankerViewModel
    
    @EnvironmentObject var dataLoader: DataLoader

    @State private var showingSheet = false

    
    var body: some View {
        if #available(iOS 15.0, *) {
            NavigationView(){
                VStack {
                    Picker("Sort Type", selection: $rankerViewModel.sortType) {
                        Text("Best").tag(0)
                        Text("Worst").tag(1)
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    
                    List() {
                        Section(header: Text(String("Through week \(Version.shared.throughWeek)"))) {
                            ForEach(rankerViewModel.filteredRankTeams){ team in
                                NavigationLink {
                                    TeamDetailView(team: team)
                                } label: {
                                    VStack {
                                        HStack {
                                            Text(String(team.ranking ?? 0)).bold()
                                            Text(". ").bold()
                                            Text(team.name ?? "UNKNOWN").bold()
                                            Text(String(team.rankingScore ?? 0)).fontWeight(.light)
                                            Spacer()
                                        }
                                    }.frame(height: 50)
                                }
                            }
                        }
                    }
                    .toolbar {
                        ToolbarItemGroup(placement: ToolbarItemPlacement.navigationBarLeading) {
                            Button("Week") {
                                showingSheet.toggle()
                            }
                            .sheet(isPresented: $showingSheet) {
                                VersionSelectorView()
                            }
                        }
                        ToolbarItemGroup(placement: ToolbarItemPlacement.navigationBarTrailing) {
                            Button("Push To DB") {
                               NCAAFTrackerAPI.shared.addWeeklyRanking(teams: rankerViewModel.rankedTeams)
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                    .searchable(text: $rankerViewModel.searchQuery, prompt: "Search By Team")
                    .navigationTitle("Rankings")
                }
            }
        } else {
            // Fallback on earlier versions
        }

    }
}

//struct RankerView_Previews: PreviewProvider {
//    static var previews: some View {
//        RankerView()
//    }
//}
