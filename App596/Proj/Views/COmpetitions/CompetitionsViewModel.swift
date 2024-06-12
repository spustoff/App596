//
//  CompetitionsViewModel.swift
//  App596
//
//  Created by IGOR on 02/06/2024.
//

import SwiftUI
import CoreData
import CoreData

final class CompetitionsViewModel: ObservableObject {

    @Published var photos: [String] = ["1", "2", "3"]
    @Published var currentPhoto = ""

    @Published var isAdd: Bool = false
    @Published var isAddCompetition: Bool = false
    @Published var isDelete: Bool = false
    @Published var isReset: Bool = false
    @Published var isDetail: Bool = false
    @Published var isMore: Bool = false
    
    @Published var compPhoto = ""
    @Published var compName = ""
    @Published var compDate = ""
    @Published var compPlace = ""
    
    @Published var competitions: [CompModel] = []
    @Published var selectedCompetition: CompModel?
    
    func addCompetition() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "CompModel", into: context) as! CompModel
        
        loan.compPhoto = compPhoto
        loan.compName = compName
        loan.compDate = compDate
        loan.compPlace = compPlace
        
        CoreDataStack.shared.saveContext()
    }
    
    func fetchCompetitions() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<CompModel>(entityName: "CompModel")
        
        do {
            
            let result = try context.fetch(fetchRequest)
            
            self.competitions = result
            
        } catch let error as NSError {
            
            print("catch")
            
            print("Error fetching persons: \(error), \(error.userInfo)")
            
            self.competitions = []
        }
    }
}


