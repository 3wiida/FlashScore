//
//  LeagueMatchesResponse.swift
//  FlashScore
//
//  Created by 3wiida on 16/05/2025.
//

struct FootballLeagueMatchesResponse: Codable {
    let result: [FootballMatch]?
}

struct BasketballLeagueMatchesResponse: Codable {
    let result: [BasketballMatch]?
}

struct TennisLeagueMatchesResponse: Codable {
    let result: [TennisMatch]?
}

struct CricketLeagueMatchesResponse: Codable {
    let result: [CricketMatch]?
}

struct CommonMatch {
    let event_date: String
    let event_time: String
    let event_home_team: String
    let event_away_team: String
    let home_team_logo: String
    let away_team_logo: String
    let event_final_result: String
}

struct FootballMatch: Codable {
    let event_date: String
    let event_time: String
    let event_home_team: String
    let event_away_team: String
    let home_team_logo: String
    let away_team_logo: String
    let event_final_result: String
    
    func toCommonMatch() -> CommonMatch {
        return CommonMatch(
            event_date: self.event_date,
            event_time: self.event_time,
            event_home_team: self.event_home_team,
            event_away_team: self.event_away_team,
            home_team_logo: self.home_team_logo,
            away_team_logo: self.away_team_logo,
            event_final_result: self.event_final_result
        )
    }
}

struct BasketballMatch: Codable {
    let event_date: String
    let event_time: String
    let event_home_team: String
    let event_away_team: String
    let event_home_team_logo: String
    let event_away_team_logo: String
    let event_final_result: String
    
    func toCommonMatch() -> CommonMatch {
        return CommonMatch(
            event_date: self.event_date,
            event_time: self.event_time,
            event_home_team: self.event_home_team,
            event_away_team: self.event_away_team,
            home_team_logo: self.event_home_team_logo,
            away_team_logo: self.event_away_team_logo,
            event_final_result: self.event_final_result
        )
    }
}

struct TennisMatch: Codable {
    let event_date: String
    let event_time: String
    let event_first_player: String
    let event_second_player: String
    let event_first_player_logo: String
    let event_second_player_logo: String
    let event_final_result: String
    
    func toCommonMatch() -> CommonMatch {
        return CommonMatch(
            event_date: self.event_date,
            event_time: self.event_time,
            event_home_team: self.event_first_player,
            event_away_team: self.event_second_player,
            home_team_logo: self.event_first_player_logo,
            away_team_logo: self.event_second_player_logo,
            event_final_result: self.event_final_result
        )
    }
}

struct CricketMatch: Codable {
    let event_date_start: String
    let event_time: String
    let event_home_team: String
    let event_away_team: String
    let event_home_team_logo: String
    let event_away_team_logo: String
    let event_home_final_result: String
    let event_away_final_result: String
    
    func toCommonMatch() -> CommonMatch {
        return CommonMatch(
            event_date: self.event_date_start,
            event_time: self.event_time,
            event_home_team: self.event_home_team,
            event_away_team: self.event_away_team,
            home_team_logo: self.event_home_team_logo,
            away_team_logo: self.event_away_team_logo,
            event_final_result: "\(self.event_home_final_result) - \(self.event_away_final_result)"
        )
    }
}
