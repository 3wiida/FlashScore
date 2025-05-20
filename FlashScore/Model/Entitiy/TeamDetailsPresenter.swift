//
//  TeamDetailsPresenter.swift
//  FlashScore
//
//  Created by ziad helaly on 19/05/2025.
//

import Foundation

protocol TeamDetailsPresenterContract {
    func attachViewController(view:TeamDetailsViewContract)
    
    func getTeamDetails(teamId:String, sportType:SportType)
}
protocol TeamDetailsViewContract {
    func renderData(teamDetails:Team?)
    func showErrorMsg(msg:String)
}
class TeamDetailsPresenter: TeamDetailsPresenterContract{
    
    private var view:TeamDetailsViewContract!
    func attachViewController(view: TeamDetailsViewContract) {
        self.view=view
    }
    
    func getTeamDetails(teamId: String, sportType: SportType) {
        ApiServiceImpl.fetchTeamDetails(sportType: sportType, teamId: teamId) { [weak self](response, error) in
            if let error = error{
                self?.view.showErrorMsg(msg: error.localizedDescription)
            }else{
                self?.view.renderData(teamDetails: response?.result[0])
            }
        }
    }
    
    
    
    
}
