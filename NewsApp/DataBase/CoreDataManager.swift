//
//  CoreDataManager.swift
//  NewsApp
//
//  Created by Alexandra Boar on 15.01.2024.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    static let shared = CoreDataManager()
    
    func addArticle(article: Article) {
        let articleEntity = ArticleEntity(context: persistentContainer.viewContext)
        articleEntity.title = article.title
        articleEntity.author = article.author
        articleEntity.content = article.content
        articleEntity.url = article.url
        articleEntity.urlToImage = article.urlToImage
    }
    
    private func getArticleEntities() -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ArticleEntity")
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest) as! [NSManagedObject]
        } catch {
            return []
        }
    }
    
    func getFavoriteArticles() -> [Article] {
        let managedObjects = getArticleEntities()
        let articles = managedObjects.map { managedObject in
            Article(
                author: managedObject.value(forKey: "author") as? String,
                title: managedObject.value(forKey: "title") as? String,
                content: managedObject.value(forKey: "content") as? String,
                url: managedObject.value(forKey: "url") as? String,
                urlToImage: managedObject.value(forKey: "urlToImage") as? String
            )
        }
        return articles
    }
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
