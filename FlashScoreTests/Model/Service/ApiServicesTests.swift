//
//  ApiServicesTests.swift
//  FlashScoreTests
//
//  Created by 3wiida on 19/05/2025.
//

import XCTest
@testable import FlashScore

class ApiServicesTests : XCTestCase {
        
    func testFetchAllLeagues() {
        // Arrange
        let exp = expectation(description: "Leagues loaded")
        let sport: SportType = .FOOTBALL

        // Act
        ApiServiceImpl.fetchAllLeagues(sportType: sport) { response, error in
            // Assert
            if let error = error {
                XCTFail("API call failed – \(error)")
            } else {
                XCTAssertNotNil(response)
                XCTAssertFalse(response!.result.isEmpty, "No leagues returned")
            }
            exp.fulfill()
        }

        waitForExpectations(timeout: 5)
    }
    
    func testFetchLeagueMatches_live() {
        // Arrange
        let exp = expectation(description: "Matches loaded")
        let sport: SportType = .FOOTBALL
        let leagueID = "141"
        let startDate = "2025-05-01"
        let endDate = "2025-05-31"

        // Act
        ApiServiceImpl.fetchLeagueMatches(
            sportType: sport,
            leagueId: leagueID,
            startDate: startDate,
            endDate: endDate,
            responseType: FootballLeagueMatchesResponse.self
        ) { response, error in
            // Assert
            if let error = error {
                XCTFail("Request failed – \(error)")
            } else {
                XCTAssertNotNil(response, "Response is nil")
                XCTAssertFalse(response!.result?.isEmpty ?? true, "No matches returned for \(leagueID)")
            }
            exp.fulfill()
        }

        waitForExpectations(timeout: 5)
    }
    func testFetchTeamDetails(){
        //Given
        let exp = expectation(description: "Get Details")
        let teamId="96"
        let sportType:SportType = .FOOTBALL
        
        //When
        ApiServiceImpl.fetchTeamDetails(sportType: sportType, teamId: teamId) { (response, error) in
            //Then
            if let error = error {
                XCTFail("Request failed – \(error)")
            } else {
                XCTAssertNotNil(response, "Response is nil")
                XCTAssertFalse(response!.result.isEmpty)
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    func testFetchTennisPlayerDetails(){
        //Given
        let exp = expectation(description: "Get tennis player Details")
        let playerId="1905"
        
        //When
        ApiServiceImpl.fetchTennisPlayerDetails(playerId: playerId){ (response, error) in
            //Then
            if let error = error {
                XCTFail("Request failed – \(error)")
            } else {
                XCTAssertNotNil(response, "Response is nil")
                XCTAssertFalse(response!.result.isEmpty)
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    func testLeagueTeams(){
        //Given
        let exp = expectation(description: "Get Teams")
        let sport: SportType = .FOOTBALL
        let leagueID = "141"
        //When
        ApiServiceImpl.fetchLeagueTeams(sportType: sport, leagueId: leagueID, responseType: FootballLeagueTeamsResponse.self) { (response, error) in
            
            //Then
            if let error = error {
                XCTFail("Request failed – \(error)")
            } else {
                XCTAssertNotNil(response, "Response is nil")
                XCTAssertFalse(response!.result.isEmpty)
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
}
