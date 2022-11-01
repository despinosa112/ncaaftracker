//
//  NCAAFTrackerAPI.swift
//  NCAAFTracker
//
//  Created by Daniel Espinosa on 10/9/22.
//

import UIKit
import FirebaseFirestore


class NCAAFTrackerAPI: NSObject {
    
    internal let db = Firestore.firestore()
    static let shared = NCAAFTrackerAPI()
    
}
