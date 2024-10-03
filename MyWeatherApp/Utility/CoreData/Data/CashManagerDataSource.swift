//
//  CashManagerDataSource.swift
//  MyWeatherApp
//
//  Created by Islam Abd El-Rahiem on 03/10/2024.
//

import CoreData

struct CashManagerDataSource: CashManagerDataSourceProtocol {
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "MyWeatherApp")
        container.loadPersistentStores { description, error in
            if error != nil {
                fatalError("Cannot Load Core Data Model")
            }
        }
    }
    
    func saveCity(name: String, days: [DailyWeatherRowViewModel]) async throws {
        let context = container.viewContext
        for day in days {
            let city = CityEntity(context: context)
            city.city = name
            city.id = day.id
            city.fullDescription = day.fullDescription
            city.temperature = day.temperature
            city.title = day.title
            city.day = day.day
            city.month = day.month
        }
        saveContext()
    }
    
    func fetchCity(with name: String) async throws -> [DailyWeatherRowViewModel] {
        let request = CityEntity.fetchRequest()
        let filterArray = try container.viewContext.fetch(request).filter({ $0.city == name })
        return filterArray.map({ item in
            DailyWeatherRowViewModel(city: item)
        })
    }
    
    
    //Private Functions
    private func getEntityByName(_ name: String)  throws  -> CityEntity?{
        let request = CityEntity.fetchRequest()
        request.fetchLimit = 1
        request.predicate = NSPredicate(
            format: "name = %@", name)
        let context =  container.viewContext
        let todoCoreDataEntity = try? context.fetch(request)[0]
        return todoCoreDataEntity
    }
    
    private func saveContext(){
        let context = container.viewContext
        if context.hasChanges {
            do{
                try context.save()
            }catch{
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
}
