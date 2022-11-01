//
//  TeamsSorter.swift
//  NCAAFTrackerTests
//
//  Created by Daniel Espinosa on 10/19/22.
//

import XCTest
@testable import NCAAFTracker


class TeamsSorterTests: XCTestCase {
    
    var teams: [Team]!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let teamA = Team(id: "1", name: "teamA", conId: nil, totalWins: nil, totalLosses: nil, fbsDefeatedOpponentIds: nil, totalWinsOfFBSDefeatedOpponents: nil, ranking: nil, scoreDifferential: nil, games: nil)
        let teamB = Team(id: "2", name: "teamB", conId: nil, totalWins: nil, totalLosses: nil, fbsDefeatedOpponentIds: nil, totalWinsOfFBSDefeatedOpponents: nil, ranking: nil, scoreDifferential: nil, games: nil)
        let teamC = Team(id: "3", name: "teamB", conId: nil, totalWins: nil, totalLosses: nil, fbsDefeatedOpponentIds: nil, totalWinsOfFBSDefeatedOpponents: nil, ranking: nil, scoreDifferential: nil, games: nil)
        
        let teams = [teamA, teamC, teamB]
        self.teams = teams
        
    }
    
    func testHappyPath() throws {
        let sortedTeams = TeamsSorter.sortTeamsById(teams: teams)
        XCTAssertEqual(sortedTeams.count, 3)
        XCTAssertEqual(sortedTeams[0].id, "1")
        XCTAssertEqual(sortedTeams[1].id, "2")
        XCTAssertEqual(sortedTeams[2].id, "3")

    }

}
