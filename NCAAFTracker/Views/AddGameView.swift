//
//  AddGameView.swift
//  NCAAFTracker
//
//  Created by Daniel Espinosa on 10/10/22.
//

import SwiftUI

struct AddGameView: View {
    
    @StateObject private var addGameViewModel = AddGameViewModel()


    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(
                        header: Text("Game Info"),
                        footer: HStack {
                            Spacer()
                            Text(addGameViewModel.inlineError).foregroundColor(Color.red)
                            Spacer()
                        }
                    ) {
                        
                        NavigationLink((addGameViewModel.aTeam == nil ? "team A" : addGameViewModel.aTeam?.name) ?? "FCS Team") {
                            if #available(iOS 15.0, *) {
                                AutoCompleteTeamView(autoCompleteTeamViewModel: AutoCompleteTeamViewModel(selectorId: "A"))
                            }
                        }.foregroundColor(addGameViewModel.aTeam == nil ? Color.gray : Color.black)
                        
                        
                        TextField("team a Score", text: $addGameViewModel.aScore).autocapitalization(.none).keyboardType(.numberPad)
                        
                        NavigationLink((addGameViewModel.bTeam == nil ? "team B" : addGameViewModel.bTeam?.name) ?? "FCS Team") {
                            if #available(iOS 15.0, *) {
                                AutoCompleteTeamView(autoCompleteTeamViewModel: AutoCompleteTeamViewModel(selectorId: "B"))
                            }
                        }.foregroundColor(addGameViewModel.aTeam == nil ? Color.gray : Color.black)
                        
                        
                        TextField("team b Score", text: $addGameViewModel.bScore).autocapitalization(.none).keyboardType(.numberPad)
                    }

     
                }
                Button(action: {
                    addGameViewModel.addGame()
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }){
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 60)
                        .overlay(Text("Add Game").foregroundColor(.white))
                }
                .padding()
            }
            .navigationTitle("Add Game")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


struct AddGameView_Previews: PreviewProvider {
    static var previews: some View {
        AddGameView()
    }
}
