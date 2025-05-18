//
//  FavouritesPresenter.swift
//  FlashScore
//
//  Created by ziad helaly on 17/05/2025.
//

import Foundation
protocol FavouritesPresnterContract {
    func attachViewController(viewController:FavouriteViewControllerContract)
    func getFavourites()
    func deleteFromFavourites(leagueKey: Int)
}
class FavouritesPresenter:FavouritesPresnterContract{
    
    private var favouritesView:FavouriteViewControllerContract!
    func attachViewController(viewController:FavouriteViewControllerContract){
        favouritesView=viewController
    }
    func getFavourites(){
        CoreDataService.shared.getLeagues{[weak self] leagues,error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if let error = error {
                    self.favouritesView.showError(msg: error.localizedDescription)
                } else {
                    self.favouritesView.viewLeagues(leagues: leagues)
                }
            }
        }
    }
    func deleteFromFavourites(leagueKey: Int) {
        CoreDataService.shared.deleteLeague(withKey: leagueKey){[weak self]success in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if(success){
                    self.favouritesView.onDelete(msg: "League deleted successfully from favourites")
                }else{
                    self.favouritesView.showError(msg: "Something went wrong!!")
                }
            }
        }
    }
}
