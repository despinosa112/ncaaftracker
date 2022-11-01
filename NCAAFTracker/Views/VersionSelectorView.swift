//
//  VersionSelectorView.swift
//  NCAAFTracker
//
//  Created by Daniel Espinosa on 10/27/22.
//

import SwiftUI

@available(iOS 15.0, *)
struct VersionSelectorView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("Select Week").padding()
            List(){
                ForEach(1...Version.shared.throughWeekMax, id: \.self) { index in
                    Button {
                        Version.shared.throughWeek = index
                        dismiss()
                    } label: {
                        HStack {
                            Spacer()
                            Text(String(describing: "Week \(index)"))
                                .foregroundColor(Color.gray)
                            Spacer()
                        }
                    }
                }
            }
            
        }
    }
}

struct WeekSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15.0, *) {
            VersionSelectorView()
        } else {
            // Fallback on earlier versions
        }
    }
}
