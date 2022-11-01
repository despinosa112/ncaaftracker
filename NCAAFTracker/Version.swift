//
//  Version.swift
//  NCAAFTracker
//
//  Created by Daniel Espinosa on 10/27/22.
//

import Foundation

class Version: NSObject {
    
    static let shared = Version()

    var throughWeekMax = 15
    
    var throughWeek = 8 {
        didSet {
            updatedThroughWeek()
        }
    }
    
    func updatedThroughWeek(){
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("updatedThroughWeek"), object: throughWeek)
    }
    
}
