//
//  AllLeaguesViewController.swift
//  FlashScore
//
//  Created by 3wiida on 12/05/2025.
//

import UIKit

class AllLeaguesViewController: UIViewController {

    var leagues: [League] = [
        League(league_key: "", league_name: "Mahmoud", country_name: "Egypt", league_logo: nil),
        League(league_key: "", league_name: "Mahmoud", country_name: "Egypt", league_logo: nil),
        League(league_key: "", league_name: "Mahmoud", country_name: "Egypt", league_logo: nil),
        League(league_key: "", league_name: "Mahmoud", country_name: "Egypt", league_logo: nil),
        League(league_key: "", league_name: "Mahmoud", country_name: "Egypt", league_logo: nil),
        League(league_key: "", league_name: "Mahmoud", country_name: "Egypt", league_logo: nil),
        League(league_key: "", league_name: "Mahmoud", country_name: "Egypt", league_logo: nil),
        League(league_key: "", league_name: "Mahmoud", country_name: "Egypt", league_logo: nil),
        League(league_key: "", league_name: "Mahmoud", country_name: "Egypt", league_logo: nil),
        League(league_key: "", league_name: "Mahmoud", country_name: "Egypt", league_logo: nil),
        League(league_key: "", league_name: "Mahmoud", country_name: "Egypt", league_logo: nil),
        League(league_key: "", league_name: "Mahmoud", country_name: "Egypt", league_logo: nil),
        League(league_key: "", league_name: "Mahmoud", country_name: "Egypt", league_logo: nil),
        League(league_key: "", league_name: "Mahmoud", country_name: "Egypt", league_logo: nil),
        League(league_key: "", league_name: "Mahmoud", country_name: "Egypt", league_logo: nil),
        League(league_key: "", league_name: "Mahmoud", country_name: "Egypt", league_logo: nil),
        League(league_key: "", league_name: "Mahmoud", country_name: "Egypt", league_logo: nil),
        League(league_key: "", league_name: "Mahmoud", country_name: "Egypt", league_logo: nil),
        League(league_key: "", league_name: "Mahmoud", country_name: "Egypt", league_logo: nil),
        League(league_key: "", league_name: "Mahmoud", country_name: "Egypt", league_logo: nil),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension AllLeaguesViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LeagueTableViewCell.identifier, for: indexPath) as! LeagueTableViewCell
        cell.setupCell(league: leagues[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
}
