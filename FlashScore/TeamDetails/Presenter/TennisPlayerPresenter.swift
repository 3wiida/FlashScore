//
//  TennisPlayerPresenter.swift
//  FlashScore
//
//  Created by ziad helaly on 20/05/2025.
//

import Foundation
protocol TennisPlayerPresenterContract {
    func getData(playerId:String)
    func attachViewController(view:TennisPlayerViewContract)
}
class TennisPlayerPresenter:TennisPlayerPresenterContract{
    private var view:TennisPlayerViewContract!
    
    func attachViewController(view: TennisPlayerViewContract) {
        self.view=view
    }
    
    func getData(playerId:String) {
        ApiServiceImpl.fetchTennisPlayerDetails(playerId: playerId) { [weak self](respones, error) in
            if let error=error{
                print(error.localizedDescription)
            }else{
                self?.view.renderData(player: respones?.result[0])
            }
        }
    }
    
    
    
}

