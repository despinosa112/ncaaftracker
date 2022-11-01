//
//  Conference.swift
//  NCAAFTracker
//
//  Created by Daniel Espinosa on 10/9/22.
//

import Foundation
import FirebaseFirestoreSwift

struct Conference: Codable, Identifiable {
    @DocumentID var id: String?
    let name: String?
    var teams: [Team]?
}
