//
//  LeagueDetailsPresenter.swift
//  FlashScore
//
//  Created by 3wiida on 16/05/2025.
//

import Foundation

protocol LeagueDetailsPresenterContract {
    func fetchUpcomingMatches(sportType: SportType, leagueId:String)
    func fetchLatestMatches(sportType: SportType, leagueId:String)
    func fetchLeagueTeams(sportType: SportType, leagueId:String)
    
    func isLeagueSaved(leagueKey: Int) -> Bool
    func addLeagueToFav(league: League)
    func removeLeagueFromFav(key: Int)
    
    func attachViewController(view: LeagueDetailsViewContract)
}

class LeagueDetailsPresenter : LeagueDetailsPresenterContract {
    
    private var leagueDetailsView: LeagueDetailsViewContract? = nil
    
    func fetchUpcomingMatches(sportType: SportType, leagueId: String) {
        /*
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd"

        let today = Date()
        let oneWeek = Calendar.current.date(byAdding: .day, value: 7, to: today)!

        let startDateString = formatter.string(from: today)
        let endDateString   = formatter.string(from: oneWeek)
        
        ApiServiceImpl.fetchLeagueMatches(
            sportType: sportType,
            leagueId: leagueId,
            startDate: startDateString,
            endDate: endDateString,
            responseType: getMatchesResponseType(sportType: sportType)
        ) { response, error in
            guard let leagueDetailsView = self.leagueDetailsView else {
                return
            }
            
            if let error = error {
                leagueDetailsView.showErrorMessage(error: error)
            }else {
                    switch sportType {
                    case .FOOTBALL:
                        leagueDetailsView.onUpcomingMatchesAvailable(
                            matches: ((response as? FootballLeagueMatchesResponse)?.result ?? [FootballMatch]()).map({ footballMatch in
                                footballMatch.toCommonMatch()
                        }))
                    case .BASKETBALL:
                        leagueDetailsView.onUpcomingMatchesAvailable(
                            matches: ((response as? BasketballLeagueMatchesResponse)?.result ?? [BasketballMatch]()).map({ basketballMatch in
                                basketballMatch.toCommonMatch()
                            })
                        )
                    case .TENNIS:
                        leagueDetailsView.onUpcomingMatchesAvailable(
                            matches: ((response as? TennisLeagueMatchesResponse)?.result ?? [TennisMatch]()).map({ tennisMatch in
                                tennisMatch.toCommonMatch()
                            })
                        )
                    case .CRICKET:
                        leagueDetailsView.onUpcomingMatchesAvailable(
                            matches: ((response as? CricketLeagueMatchesResponse)?.result ?? [CricketMatch]()).map({ cricketMatch in
                                cricketMatch.toCommonMatch()
                            })
                        )
                    }
            }
        }*/
    }
    
    func fetchLatestMatches(sportType: SportType, leagueId: String) {
        /*
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd"

        let today = Date()
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let sevenDaysAgo = Calendar.current.date(byAdding: .day, value: -7, to: yesterday)!

        let startDateString = formatter.string(from: sevenDaysAgo)
        let endDateString   = formatter.string(from: yesterday)
        
        ApiServiceImpl.fetchLeagueMatches(
            sportType: sportType,
            leagueId: leagueId,
            startDate: startDateString,
            endDate: endDateString,
            responseType: getMatchesResponseType(sportType: sportType)
        ) { response, error in
            guard let leagueDetailsView = self.leagueDetailsView else {
                return
            }
            
            if let error = error {
                leagueDetailsView.showErrorMessage(error: error)
            }else {
                switch sportType {
                case .FOOTBALL:
                    leagueDetailsView.onLatestMatchesAvailable(
                        matches: ((response as? FootballLeagueMatchesResponse)?.result ?? [FootballMatch]()).map({ footballMatch in
                            footballMatch.toCommonMatch()
                    }))
                case .BASKETBALL:
                    leagueDetailsView.onLatestMatchesAvailable(
                        matches: ((response as? BasketballLeagueMatchesResponse)?.result ?? [BasketballMatch]()).map({ basketballMatch in
                            basketballMatch.toCommonMatch()
                        })
                    )
                case .TENNIS:
                    leagueDetailsView.onLatestMatchesAvailable(
                        matches: ((response as? TennisLeagueMatchesResponse)?.result ?? [TennisMatch]()).map({ tennisMatch in
                            tennisMatch.toCommonMatch()
                        })
                    )
                case .CRICKET:
                    leagueDetailsView.onLatestMatchesAvailable(
                        matches: ((response as? CricketLeagueMatchesResponse)?.result ?? [CricketMatch]()).map({ cricketMatch in
                            cricketMatch.toCommonMatch()
                        })
                    )
                }
            }
        }*/
    }
    
    func fetchLeagueTeams(sportType: SportType, leagueId: String) {
        /*ApiServiceImpl.fetchLeagueTeams(
            sportType: sportType,
            leagueId: leagueId,
            responseType: getTeamsResponseType(sportType: sportType)
        ) { response, error in
            guard let leagueDetailsView = self.leagueDetailsView else {
                return
            }
            
            if let _ = error {
                //leagueDetailsView.showErrorMessage(error: error)
            }else {
                switch sportType {
                case .FOOTBALL:
                    leagueDetailsView.onTeamsAvailable(
                        teams: (response as? FootballLeagueTeamsResponse)?.result.map({ team in
                            team.toCommonTeam()
                    }) ?? [])
                case .BASKETBALL:
                    leagueDetailsView.onTeamsAvailable(
                        teams: (response as? BasketballLeagueTeamsResponse)?.result.map({ team in
                            team.toCommonTeam()
                    }) ?? [])
                case .TENNIS:
                    leagueDetailsView.onTeamsAvailable(
                        teams: (response as? TennisLeagueTeamsResponse)?.result.map({ team in
                            team.toCommonTeam()
                    }) ?? [])
                case .CRICKET:
                    leagueDetailsView.onTeamsAvailable(
                        teams: (response as? CricketLeagueTeamsResponse)?.result.map({ team in
                            team.toCommonTeam()
                    }) ?? [])
                }
            }
        }*/
    }
    
    private func getMatchesResponseType(sportType: SportType) -> Decodable.Type {
        switch sportType {
        case .FOOTBALL:
            return FootballLeagueMatchesResponse.self
        case .BASKETBALL:
            return BasketballLeagueMatchesResponse.self
        case .TENNIS:
            return TennisLeagueMatchesResponse.self
        case .CRICKET:
            return CricketLeagueMatchesResponse.self
        }
    }
    
    private func getTeamsResponseType(sportType: SportType) -> Decodable.Type {
        switch sportType {
        case .FOOTBALL:
            return FootballLeagueTeamsResponse.self
        case .BASKETBALL:
            return BasketballLeagueTeamsResponse.self
        case .TENNIS:
            return TennisLeagueTeamsResponse.self
        case .CRICKET:
            return CricketLeagueTeamsResponse.self
        }
    }
    
    func attachViewController(view: LeagueDetailsViewContract) {
        self.leagueDetailsView = view
    }
    
    
    func isLeagueSaved(leagueKey: Int) -> Bool {
        return CoreDataService.shared.isLeagueExists(key: leagueKey)
    }
    
    func addLeagueToFav(league: League) {
        CoreDataService.shared.saveLeague(league) { isSuccess, error in
            if isSuccess {
                self.leagueDetailsView?.onFavStateUpdated(isFav: true)
            }
        }
    }
    
    func removeLeagueFromFav(key: Int) {
        CoreDataService.shared.deleteLeague(withKey: key) { isSuccess in
            if isSuccess {
                self.leagueDetailsView?.onFavStateUpdated(isFav: false)
            }
        }
    }
}
