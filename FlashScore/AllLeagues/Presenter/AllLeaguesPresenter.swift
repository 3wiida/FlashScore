//
//  AllLeaguesPresenter.swift
//  FlashScore
//
//  Created by 3wiida on 13/05/2025.
//

protocol AllLeaguesPresenterContract {
    func getAllLeagues(sportType: SportType)
    func attachViewController(view: AllLeaguesViewControllerContract)
}

class AllLeaguesPresenter: AllLeaguesPresenterContract {
    
    private var allLeaguesView:AllLeaguesViewControllerContract? = nil
    
    func attachViewController(view: AllLeaguesViewControllerContract) {
        self.allLeaguesView = view
    }
    
    func getAllLeagues(sportType: SportType) {
        ApiServiceImpl.fetchAllLeagues(sportType: sportType) { response, error in
            guard let allLeaguesView = self.allLeaguesView else {
                return
            }
            
            if let error = error {
                allLeaguesView.showErrorMsg(error: error)
            }else {
                allLeaguesView.onLeaguesResponseAvailable(leagues: response?.result ?? [])
            }
            
        }
    }
}
