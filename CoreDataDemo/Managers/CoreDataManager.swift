//
//  CoreDataManager.swift
//  CoreDataDemo
//
//  Created by Shubham Kumar on 01/02/22.
//

import Foundation
import CoreData
import SwiftUI

class CoreDataManager {
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "CoreDataDemoModel")
        persistentContainer.loadPersistentStores {
            (description, error) in
            if let error = error {
                fatalError("Core Data Store Failed! -> \(error.localizedDescription)")
            }
        }
    }
    //updateMovie
    func updateMovie() {
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
        }
    }
    
    //delete movie
    func deleteMovie(movie: Movie) {
        persistentContainer.viewContext.delete(movie)
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Cannot delete and failed to save the context : \(error)")
        }
    }
    
    //Create operation
    func saveMovie(title: String) {
        let movie = Movie(context: persistentContainer.viewContext)
        movie.title = title
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Failed to save or create movie : \(error)")
        }
    }
    
    // Read,Get Movies
    func getAllMovies() -> [Movie] {
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
}
