//
//  LeagueTeamsResponse.swift
//  FlashScore
//
//  Created by 3wiida on 16/05/2025.
//

struct FootballLeagueTeamsResponse: Codable {
    let result: [FootballTeam]
}

struct BasketballLeagueTeamsResponse: Codable {
    let result: [BasketballTeam]
}

struct TennisLeagueTeamsResponse: Codable {
    let result: [TennisPlayer]
}

struct CricketLeagueTeamsResponse: Codable {
    let result: [CricketTeam]
}

struct CommonTeam {
    let team_key: Int
    let team_name: String
    let team_logo: String
}

struct FootballTeam: Codable {
    let team_key: Int?
    let team_name: String?
    let team_logo: String?
    
    func toCommonTeam()-> CommonTeam {
        return CommonTeam(team_key: self.team_key ?? 0, team_name: self.team_name ?? "", team_logo: self.team_logo ?? "")
    }
}

struct BasketballTeam: Codable {
    let team_key: Int?
    let team_name: String?
    let team_logo: String?
    
    func toCommonTeam()-> CommonTeam {
        return CommonTeam(team_key: self.team_key ?? 0, team_name: self.team_name ?? "", team_logo: self.team_logo ?? "")
    }
}

struct TennisPlayer: Codable {
    let player_key: Int?
    let player_name: String?
    let player_logo: String?
    
    func toCommonTeam()-> CommonTeam {
        return CommonTeam(team_key: self.player_key ?? 0, team_name: self.player_name ?? "", team_logo: self.player_logo ?? "")
    }
}

struct CricketTeam: Codable {
    let team_key: Int?
    let team_name: String?
    let team_logo: String?
    
    func toCommonTeam()-> CommonTeam {
        return CommonTeam(team_key: self.team_key ?? 0, team_name: self.team_name ?? "", team_logo: self.team_logo ?? "")
    }
}
