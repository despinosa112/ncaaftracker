//
//  LineItemView.swift
//  NCAAFTracker
//
//  Created by Daniel Espinosa on 10/19/22.
//

import SwiftUI

struct LineItemView: View {
    var key: String
    var value: String
    var body: some View {
        HStack {
            HStack {
                Text(key).bold()
                Text(value)
            }
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
            Spacer()
        }
        
    }
}

struct LineItemView_Previews: PreviewProvider {
    static var previews: some View {
        LineItemView(key: "KEY", value: "VALUE")
    }
}
