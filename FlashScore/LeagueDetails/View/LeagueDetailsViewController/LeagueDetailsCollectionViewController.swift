//
//  LeagueDetailsCollectionViewController.swift
//  FlashScore
//
//  Created by 3wiida on 16/05/2025.
//

import UIKit

protocol LeagueDetailsViewContract {
    func onUpcomingMatchesAvailable(matches: [CommonMatch])
    func onLatestMatchesAvailable(matches: [CommonMatch])
    func onTeamsAvailable(teams: [CommonTeam])
    func onFavStateUpdated(isFav: Bool)
    func showErrorMessage(error: Error)
}

class LeagueDetailsCollectionViewController: UICollectionViewController {
    
    private let presenter = LeagueDetailsPresenter()
    
    private var upcomingMatches: [CommonMatch] = []
    private var latestMatches: [CommonMatch] = []
    private var teams: [CommonTeam] = []
    
    var sportType = SportType.FOOTBALL
    var isFavorite = true
    var isUpcomingMatchesLoading = true
    var isLatestMatchesLoading = true
    var isTeamsLoading = true
    var league: League!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Fixtures"
        isFavorite = presenter.isLeagueSaved(leagueKey: league.league_key)
        
        configureHeartButton()
        setupCollectionView()
        
        presenter.attachViewController(view: self)
        presenter.fetchUpcomingMatches(sportType: sportType, leagueId: "\(league.league_key)")
        presenter.fetchLatestMatches(sportType: sportType, leagueId: "\(league.league_key)")
        presenter.fetchLeagueTeams(sportType: sportType, leagueId: "\(league.league_key)")
    }

    private func configureHeartButton() {
        let heartImageName = isFavorite ? "heart.fill" : "heart"
        let heartButton = UIBarButtonItem(
            image: UIImage(systemName: heartImageName),
            style: .plain,
            target: self,
            action: #selector(onFavClicked)
        )
        heartButton.tintColor = .red
        navigationItem.rightBarButtonItem = heartButton
    }
    
    @objc private func onFavClicked(){
        if isFavorite {
            presenter.removeLeagueFromFav(key: league.league_key)
        }else {
            presenter.addLeagueToFav(league: league)
        }
    }
}

extension LeagueDetailsCollectionViewController: LeagueDetailsViewContract {
    func onUpcomingMatchesAvailable(matches: [CommonMatch]) {
        self.isUpcomingMatchesLoading = false
        self.upcomingMatches = matches
        self.collectionView.reloadData()
    }
    
    func onLatestMatchesAvailable(matches: [CommonMatch]) {
        self.isLatestMatchesLoading = false
        self.latestMatches = matches
        self.collectionView.reloadData()
    }
    
    func onTeamsAvailable(teams: [CommonTeam]) {
        isTeamsLoading = false
        self.teams = teams
        self.collectionView.reloadData()
    }
    
    func onFavStateUpdated(isFav: Bool) {
        isFavorite = isFav
        configureHeartButton()
    }
    
    func showErrorMessage(error: Error) {
        let errorAlert = UIAlertController(
            title: "Error",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        
        let retryAction = UIAlertAction(title: "Retry", style: .default) { [weak self] _ in
            self?.presenter.fetchUpcomingMatches(sportType: self?.sportType ?? .FOOTBALL, leagueId: "\(self?.league.league_key ?? 141)")
            self?.presenter.fetchLatestMatches(sportType: self?.sportType ?? .FOOTBALL, leagueId: "\(self?.league.league_key ?? 141)")
            self?.presenter.fetchLeagueTeams(sportType: self?.sportType ?? .FOOTBALL, leagueId: "\(self?.league.league_key ?? 141)")
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        errorAlert.addAction(retryAction)
        errorAlert.addAction(cancelAction)
        
        self.present(errorAlert, animated: true)
    }
    
    
}

private extension LeagueDetailsCollectionViewController {
    func setupCollectionView() {
        collectionView.register(UINib(nibName: "LeagueMatchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MatchCell")
        collectionView.register(UINib(nibName: "LeagueMatchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MatchCell")
        collectionView.register(UINib(nibName: "LeagueTeamCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LeagueTeamCell")
        collectionView.register(UINib(nibName: "EmptyStateCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EmptyStateCell")
        collectionView.register(UINib(nibName: "LoadingStateCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LoadingStateCell")
        
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.reuseIdentifier)
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            switch sectionIndex {
                case 0: return self.drawUpcomingMatchesSection()
                case 1: return self.drawLatestMatchesSection()
                case 2: return self.drawTeamsSection()
                default: return self.drawTeamsSection()
            }
        }
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
}

extension LeagueDetailsCollectionViewController : UICollectionViewDelegateFlowLayout {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return upcomingMatches.isEmpty ? 1 : upcomingMatches.count
        case 1:
            return latestMatches.isEmpty ? 1 : latestMatches.count
        case 2:
            return teams.isEmpty ? 1 : teams.count
        default:
            return 0
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
            case 0:
                if isUpcomingMatchesLoading {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LoadingStateCell", for: indexPath)
                    return cell
                }else {
                    if upcomingMatches.isEmpty {
                        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyStateCell", for: indexPath)
                        return cell
                    }else{
                        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MatchCell", for: indexPath) as! LeagueMatchCollectionViewCell
                        cell.setup(match: upcomingMatches[indexPath.row], isUpcoming: true)
                        return cell
                    }
                }
            case 1:
                if isLatestMatchesLoading {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LoadingStateCell", for: indexPath)
                    return cell
                } else {
                    if latestMatches.isEmpty {
                        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyStateCell", for: indexPath)
                        return cell
                    }else {
                        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MatchCell", for: indexPath) as! LeagueMatchCollectionViewCell
                        cell.setup(match: latestMatches[indexPath.row], isUpcoming: false)
                        return cell
                    }
                }
                
            case 2:
                if isTeamsLoading {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LoadingStateCell", for: indexPath)
                    return cell
                }else {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LeagueTeamCell", for: indexPath) as! LeagueTeamCollectionViewCell
                    cell.setup(team: teams[indexPath.row])
                    return cell
                }
            default:
                fatalError("Unexpected section")
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            fatalError("Unsupported kind")
        }

        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: SectionHeaderView.reuseIdentifier,
            for: indexPath
        ) as! SectionHeaderView

        switch indexPath.section {
            case 0:
                header.titleLabel.text = "Upcoming Matches"
            case 1:
                header.titleLabel.text = "Latest Matches"
            case 2:
                header.titleLabel.text = "Teams"
            default:
                header.titleLabel.text = ""
        }

        return header
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            switch sportType {
            case .FOOTBALL, .BASKETBALL, .CRICKET:
                let teamDetailsVC = storyboard?.instantiateViewController(withIdentifier: "teamDetailsVC") as! TeamDetailsViewController
                teamDetailsVC.sportType = sportType
                teamDetailsVC.teamId = "\(teams[indexPath.row].team_key)"
                self.navigationController?.pushViewController(teamDetailsVC, animated: true)
            case .TENNIS:
                let playerDetailsVC = storyboard?.instantiateViewController(withIdentifier: "tennisPlayerDetailsVC") as! TennisPlayerViewController
                playerDetailsVC.playerId = "\(teams[indexPath.row].team_key)"
                self.navigationController?.pushViewController(playerDetailsVC, animated: true)
            }
        }
    }
}


private extension LeagueDetailsCollectionViewController {
    
    func drawUpcomingMatchesSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(380),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .estimated(380),
            heightDimension: .absolute(280)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 24, bottom: 16, trailing: 24)
        
        section.boundarySupplementaryItems = [createHeader()]
        
        return section
    }

    func drawLatestMatchesSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(280)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(280)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 16, trailing: 16)

        section.boundarySupplementaryItems = [createHeader()]
        
        return section
    }
    
    func drawTeamsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(190),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .estimated(190),
            heightDimension: .absolute(200)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
      
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 24, bottom: 16, trailing: 0)
        
        section.boundarySupplementaryItems = [createHeader()]
        
        return section
    }
    
    func createHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(40)
        )
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
    }
}
