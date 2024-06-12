//
//  ResultsViewModel.swift
//  App596
//
//  Created by IGOR on 01/06/2024.
//

import SwiftUI
import CoreData

final class ResultsViewModel: ObservableObject {

    @Published var things: [String] = ["Prizes", "Other"]
    @Published var currentThing = "Prizes"
    
    @AppStorage("summ") var summ: Int = 0

    @Published var isAdd: Bool = false
    @Published var isAddSwim: Bool = false
    @Published var isDelete: Bool = false
    @Published var isReset: Bool = false
    @Published var isDetail: Bool = false
    @Published var isMore: Bool = false
    
    @Published var currentHistory = ""

    @Published var hisTitle = ""
    @Published var hisPlace = ""
    @Published var hisOPlace = ""
    
    @Published var histories: [HistoryModel] = []
    @Published var selectedHistory: HistoryModel?
    
    func addHistory() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "HistoryModel", into: context) as! HistoryModel
        
        loan.hisTitle = hisTitle
        loan.hisPlace = hisPlace
        loan.hisOPlace = hisOPlace
        
        CoreDataStack.shared.saveContext()
    }
    
    func fetchHistories() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<HistoryModel>(entityName: "HistoryModel")
        
        do {
            
            let result = try context.fetch(fetchRequest)
            
            self.histories = result
            
        } catch let error as NSError {
            
            print("catch")
            
            print("Error fetching persons: \(error), \(error.userInfo)")
            
            self.histories = []
        }
    }
    
    @Published var swimName = ""
    @Published var swimRes = ""
    @Published var curHis = ""
    
    @Published var swimmings: [SwimModel] = []
    @Published var selectedSwim: SwimModel?
    
    func addSwim() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "SwimModel", into: context) as! SwimModel
        
        loan.swimName = swimName
        loan.swimRes = swimRes
        loan.curHis = curHis
        
        CoreDataStack.shared.saveContext()
    }
    
    func fetchSwimmings() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<SwimModel>(entityName: "SwimModel")
        
        do {
            
            let result = try context.fetch(fetchRequest)
            
            self.swimmings = result.filter{($0.curHis ?? "") == currentHistory}
            
        } catch let error as NSError {
            
            print("catch")
            
            print("Error fetching persons: \(error), \(error.userInfo)")
            
            self.swimmings = []
        }
    }
}

