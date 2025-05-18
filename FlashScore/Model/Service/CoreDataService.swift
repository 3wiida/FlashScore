//
//  CoreDataService.swift
//  FlashScore
//
//  Created by ziad helaly on 17/05/2025.
//

import UIKit
import CoreData
class CoreDataService {
    var context:NSManagedObjectContext!
    var entity:NSEntityDescription!
    
    static let shared=CoreDataService()
    private init(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                    fatalError("Unable to get AppDelegate")
                }
        context = appDelegate.persistentContainer.viewContext
        entity = NSEntityDescription.entity(forEntityName: "FavouritesLeagues", in: context)
    }
    func getLeagues(handler: @escaping ([League], Error?) -> Void) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavouritesLeagues")
        
        do {
            let results = try context.fetch(fetchRequest)
            
            let leagues: [League] = results.compactMap { obj in
                guard let league_key = obj.value(forKey: "league_key") as? Int,
                      let league_name = obj.value(forKey: "league_name") as? String else {
                    return nil
                }

                let country_name = obj.value(forKey: "country_name") as? String
                let league_logo = obj.value(forKey: "league_logo") as? String
                
                return League(
                    league_key: league_key,
                    league_name: league_name,
                    country_name: country_name,
                    league_logo: league_logo
                )
            }
            
            handler(leagues, nil)
            
        } catch {
            print("Failed to fetch leagues: \(error.localizedDescription)")
            handler([], error)
        }
    }
    
    func deleteLeague(withKey key: Int, completion: @escaping (Bool) -> Void) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavouritesLeagues")
        fetchRequest.predicate = NSPredicate(format: "league_key == %d", key)

        do {
            let results = try context.fetch(fetchRequest)
            if let leagueToDelete = results.first {
                context.delete(leagueToDelete)

                try context.save()
                completion(true)
            } else {
                print("No league found with key \(key)")
                completion(false)
            }
        } catch {
            print("Failed to delete league: \(error.localizedDescription)")
            completion(false)
        }
    }

    
}
