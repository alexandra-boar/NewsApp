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

    func addArticle(article: Article, imageData: Data) {
        // article -> core data entity

        // create core data entity
        let articleEntity = ArticleEntity(context: persistentContainer.viewContext)

        // set core data entity details
        articleEntity.title = article.title
        articleEntity.author = article.author
        articleEntity.content = article.content
        articleEntity.url = article.url
        articleEntity.urlToImage = article.urlToImage
        articleEntity.articleDescription = article.description
        articleEntity.image = imageData
        // save new entity
        saveContext()
    }

    private func getArticleEntities() -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ArticleEntity")
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest) as? [NSManagedObject] ?? []
        } catch {
            return []
        }
    }

    func getArticles() -> [Article] {
        let managedObjects = getArticleEntities()
        let articles = managedObjects.map { managedObject in
            Article(
                author: managedObject.value(forKey: "author") as? String,
                title: managedObject.value(forKey: "title") as? String,
                description: managedObject.value(forKey: "articleDescription") as? String,
                content: managedObject.value(forKey: "content") as? String,
                url: managedObject.value(forKey: "url") as? String,
                urlToImage: managedObject.value(forKey: "urlToImage") as? String
            )
        }
        return articles
    }

    func getArticleEntity(with url: String) -> ArticleEntity? {
        let request = NSFetchRequest<ArticleEntity>(entityName: "ArticleEntity")
        request.predicate = NSPredicate(format: "url = %@", url) // check for string
        do {
            return try persistentContainer.viewContext.fetch(request).first
        } catch let error {
            print("Failed with \(error)")
            return nil
        }
    }

    func saveImage(for articleURL: String, with imageData: Data) {
        let articleEntity = ArticleEntity(context: persistentContainer.viewContext)
        articleEntity.image = imageData
        saveContext()
    }

    func deleteArticle(url: String) {
        let articles = getArticleEntities()
        if let articleForDelete = articles.first(where: { article in
            (article.value(forKey: "url") as? String) == url
        }) {
            persistentContainer.viewContext.delete(articleForDelete)
            saveContext()
        }
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
