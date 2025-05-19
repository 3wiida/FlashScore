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
    
    static let shared = CoreDataService()
    
    private init() {
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

    func saveLeague(_ league: League, completion: @escaping (Bool, Error?) -> Void) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavouritesLeagues")
        fetchRequest.predicate = NSPredicate(format: "league_key == %d", league.league_key)

        do {
            let existing = try context.fetch(fetchRequest)
            if existing.isEmpty {
                if let entity = entity {
                    let obj = NSManagedObject(entity: entity, insertInto: context)
                    obj.setValue(league.league_key,   forKey: "league_key")
                    obj.setValue(league.league_name,  forKey: "league_name")
                    obj.setValue(league.country_name, forKey: "country_name")
                    obj.setValue(league.league_logo,  forKey: "league_logo")
                }
            } else {
                completion(true, nil)
                return
            }

            try context.save()
            completion(true, nil)

        } catch {
            context.rollback()
            completion(false, error)
        }
    }
    
    func isLeagueExists(key: Int) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavouritesLeagues")
        fetchRequest.predicate = NSPredicate(format: "league_key == %d", key)
        fetchRequest.fetchLimit = 1

        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch {
            return false
        }
    }
}
