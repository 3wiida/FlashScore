//
//  AllLeaguesViewController.swift
//  FlashScore
//
//  Created by 3wiida on 12/05/2025.
//

import UIKit

protocol AllLeaguesViewControllerContract {
    func onLeaguesResponseAvailable(leagues: [League])
    func showErrorMsg(error: Error)
}


class AllLeaguesViewController: UIViewController {

    @IBOutlet weak private var leaguesTableView: UITableView!
    @IBOutlet weak private var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak private var searchBar: UISearchBar!
    
    private let presenter: AllLeaguesPresenterContract = AllLeaguesPresenter()
    
    private var leagues: [League] = []
    private var searchResults: [League] = []
    private var searchQuery:String = ""
    var sportType: SportType = .FOOTBALL
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator.startAnimating()
        presenter.attachViewController(view: self)
        presenter.getAllLeagues(sportType: sportType)
        setupSearchBar()
        self.navigationItem.title = "All Leagues"
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

extension AllLeaguesViewController : UITableViewDelegate, UITableViewDataSource {
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let leagueDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "LeagueDetailsVC") as! LeagueDetailsCollectionViewController
        leagueDetailsVC.sportType = sportType
        leagueDetailsVC.league = leagues[indexPath.row]
        self.navigationController?.pushViewController(leagueDetailsVC, animated: true)
    }
}

extension AllLeaguesViewController: AllLeaguesViewControllerContract {
    func onLeaguesResponseAvailable(leagues: [League]) {
        loadingIndicator.stopAnimating()
        self.leagues = leagues
        leaguesTableView.reloadData()
    }
    
    func showErrorMsg(error: Error) {
        
        let errorAlert = UIAlertController(
            title: "Error",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        
        let retryAction = UIAlertAction(title: "Retry", style: .default) { _ in
            self.presenter.getAllLeagues(sportType: self.sportType)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        errorAlert.addAction(retryAction)
        errorAlert.addAction(cancelAction)
        
        self.present(errorAlert, animated: true)
    }
}


extension AllLeaguesViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange query: String) {
        searchQuery = query
        searchResults = leagues.filter { league in
            league.league_name.lowercased().contains(query.lowercased())
        }
        leaguesTableView.reloadData()
    }
}
