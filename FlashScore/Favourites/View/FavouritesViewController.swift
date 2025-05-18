//
//  FavouritesViewController.swift
//  FlashScore
//
//  Created by ziad helaly on 17/05/2025.
//

import UIKit

protocol FavouriteViewControllerContract {
    func viewLeagues(leagues:[League])
    func showError(msg:String)
    func onDelete(msg:String)
}

class FavouritesViewController: UIViewController {

    
    @IBOutlet weak private var leaguesTableView: UITableView!
    @IBOutlet weak private var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak private var searchBar: UISearchBar!
    
    private let presenter: FavouritesPresnterContract = FavouritesPresenter()
    
    private var leagues: [League] = []
    private var searchResults: [League] = []
    private var searchQuery:String = ""
    var sportType: SportType = .FOOTBALL
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator.startAnimating()
        presenter.attachViewController(viewController: self)
        presenter.getFavourites()
        setupSearchBar()
        self.navigationItem.title = "Favourites"
    }
    
    func setupSearchBar() {
        searchBar.backgroundImage = UIImage()

        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = UIColor(named: "CardColor")
            textField.textColor = .white

            
            if let leftIconView = textField.leftView as? UIImageView {
                leftIconView.image = leftIconView.image?.withRenderingMode(.alwaysTemplate)
                leftIconView.tintColor = UIColor(named: "mainColor")
            }

            if let clearButton = textField.value(forKey: "_clearButton") as? UIButton,
                let clearImage = clearButton.image(for: .normal) {
                clearButton.setImage(clearImage.withRenderingMode(.alwaysTemplate), for: .normal)
                clearButton.tintColor = UIColor(named: "mainColor")
            }
        }
    }

}

extension FavouritesViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchQuery.isEmpty ? leagues.count : searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LeagueTableViewCell.identifier, for: indexPath) as! LeagueTableViewCell
        let league = searchQuery.isEmpty ? leagues[indexPath.row] : searchResults[indexPath.row]
        cell.setupCell(league: league)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let leagueToDelete = searchQuery.isEmpty ? leagues[indexPath.row] : searchResults[indexPath.row]

            let alert = UIAlertController(
                title: "Delete Favourite",
                message: "Are you sure you want to remove '\(leagueToDelete.league_name)' from favourites?",
                preferredStyle: .alert
            )

            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
                guard let self = self else { return }
                
                self.presenter.deleteFromFavourites(leagueKey: leagueToDelete.league_key)
                
                if self.searchQuery.isEmpty {
                    self.leagues.remove(at: indexPath.row)
                } else {
                    if let originalIndex = self.leagues.firstIndex(where: { $0.league_key == leagueToDelete.league_key }) {
                        self.leagues.remove(at: originalIndex)
                    }
                    self.searchResults.remove(at: indexPath.row)
                }

                tableView.deleteRows(at: [indexPath], with: .fade)
                self.onDelete(msg: "\(leagueToDelete.league_name) removed from favourites.")
            }))

            present(alert, animated: true)
        }
    }
    /*
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let leagueToDelete = searchQuery.isEmpty ? leagues[indexPath.row] : searchResults[indexPath.row]
            
            presenter.deleteFromFavourites(leagueKey: leagueToDelete.league_key)
            
            if searchQuery.isEmpty {
                leagues.remove(at: indexPath.row)
            } else {
                // Remove from filtered list and original list
                if let originalIndex = leagues.firstIndex(where: { $0.league_key == leagueToDelete.league_key }) {
                    leagues.remove(at: originalIndex)
                }
                searchResults.remove(at: indexPath.row)
            }

            tableView.deleteRows(at: [indexPath], with: .fade)
            onDelete(msg: "\(leagueToDelete.league_name) removed from favourites.")
        }
    }*/
}

extension FavouritesViewController: FavouriteViewControllerContract {
    func viewLeagues(leagues: [League]) {
        self.leagues=leagues
        self.loadingIndicator.stopAnimating()
        self.leaguesTableView.reloadData()
    }
    
    
    
    func onDelete(msg: String) {
        let deleteAlert = UIAlertController(
            title: "LeagueDeleted",
            message: msg,
            preferredStyle: .alert
        )
        deleteAlert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(deleteAlert, animated: true)
    }
    
    
    
    func showError(msg:String) {
        
        let errorAlert = UIAlertController(
            title: "Error",
            message: msg,
            preferredStyle: .alert
        )
        
        let retryAction = UIAlertAction(title: "Retry", style: .default) { _ in
            self.presenter.getFavourites()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        errorAlert.addAction(retryAction)
        errorAlert.addAction(cancelAction)
        
        self.present(errorAlert, animated: true)
    }
}


extension FavouritesViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange query: String) {
        searchQuery = query
        searchResults = leagues.filter { league in
            league.league_name.lowercased().contains(query.lowercased())
        }
        leaguesTableView.reloadData()
    }
}
