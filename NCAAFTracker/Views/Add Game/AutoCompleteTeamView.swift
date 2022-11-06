//
//  AutoCompleteTeamView.swift
//  NCAAFTracker
//
//  Created by Daniel Espinosa on 10/11/22.
//

import SwiftUI

@available(iOS 15.0, *)
struct AutoCompleteTeamView: View {
    
    @StateObject var autoCompleteTeamViewModel: AutoCompleteTeamViewModel
    @Environment(\.presentationMode) var presentationMode
    
    
    
    var body: some View {
        List(){
            ForEach(autoCompleteTeamViewModel.filteredTeams){ team in
                Text(team.name ?? "UKNOWN")
                    .onTapGesture {
                        autoCompleteTeamViewModel.selectTeam(team: team)
                        presentationMode.wrappedValue.dismiss()
                    }
            }
        }
        .searchable(text: $autoCompleteTeamViewModel.searchText, prompt: "Start typing team name") {
            ForEach(autoCompleteTeamViewModel.filteredTeams){ team in
                Text(team.name ?? "UKNOWN")
                    .onTapGesture {
                        autoCompleteTeamViewModel.selectTeam(team: team)
                        presentationMode.wrappedValue.dismiss()
                    }
            }
        }
        .navigationTitle("Search Teams")
    }
}

struct AutoCompleteTeamView_Previews: PreviewProvider {
    static var previews: some View {
        //AutoCompleteTeamView(autoCompleteTeamViewModel: AutoCompleteTeamViewModel())
        if #available(iOS 15.0, *) {
            AutoCompleteTeamView(autoCompleteTeamViewModel: AutoCompleteTeamViewModel(selectorId: "A"))
        }
    }
}
