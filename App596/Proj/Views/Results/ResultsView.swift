//
//  ResultsView.swift
//  App596
//
//  Created by IGOR on 01/06/2024.
//

import SwiftUI

struct ResultsView: View {
    
    @StateObject var viewModel = ResultsViewModel()
    
    var body: some View {

        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 15) {
                
                Text("Results")
                    .foregroundColor(.white)
                    .font(.system(size: 26, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    
                    VStack {
                        
                        Image("diag")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 110)
                    .background(RoundedRectangle(cornerRadius: 10).fill(.white))
                    .padding(.trailing)
                    
                    VStack {
                        
                        VStack {
                            
                            Text("\(viewModel.summ)")
                                .foregroundColor(.black)
                                .font(.system(size: 20, weight: .semibold))
                            
                        }
                        .padding()
                        .frame(width: 80, height: 90)
                        .background(RoundedRectangle(cornerRadius: 10).fill(.white))
                        
                        HStack {
                            
                            Circle()
                                .fill(Color("prim"))
                                .frame(width: 5, height: 5)
                            
                            Text("Prizes")
                                .foregroundColor(.white)
                                .font(.system(size: 12, weight: .regular))
                        }
                    }
                    
                    VStack {
                        
                        VStack {
                            
                            Text("\(viewModel.summ)")
                                .foregroundColor(.black)
                                .font(.system(size: 20, weight: .semibold))
                        }
                        .padding()
                        .frame(width: 80, height: 90)
                        .background(RoundedRectangle(cornerRadius: 10).fill(.white))
                     
                        HStack {
                            
                            Circle()
                                .fill(Color.white)
                                .frame(width: 5, height: 5)
                            
                            Text("Other")
                                .foregroundColor(.white)
                                .font(.system(size: 12, weight: .regular))
                        }
                    }
                }
                
                HStack {
                
                ForEach(viewModel.things, id: \.self) { index in
                    
                    Button(action: {
                        
                        viewModel.currentThing = index
                        
                    }, label: {
                        
                        Text(index)
                            .foregroundColor(.black)
                            .font(.system(size: 13, weight: .regular))
                    })
                    .frame(maxWidth: .infinity)
                    .frame(height: 38)
                    .background(RoundedRectangle(cornerRadius: 10).fill(viewModel.currentThing == index ? Color("prim") : .white))
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .background(RoundedRectangle(cornerRadius: 10).fill(.white))
                
                HStack {
                    
                    Text("History")
                        .foregroundColor(.black)
                        .font(.system(size: 16, weight: .semibold))
                    
                    Spacer()
                    
                    Button(action: {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAdd = true
                        }
                        
                    }, label: {
                        
                        Image(systemName: "plus")
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .semibold))
                    })
                    
                }
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .background(RoundedRectangle(cornerRadius: 10).fill(.white))
                
                if viewModel.histories.isEmpty {
                    
                    VStack {
                        
                        Image("kubok")
                        
                        Text("You haven't added any entries")
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .regular))
                    }
                    .padding()
                    .frame(height: 180)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 15).fill(.white))
                    
                    Spacer()
                    
                } else {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVStack(spacing: 14) {
                            
                            ForEach(viewModel.histories, id: \.self) { index in
                                
                                Button(action: {
                                    
                                    viewModel.selectedHistory = index
                                    viewModel.currentHistory = viewModel.selectedHistory?.hisTitle ?? ""
                                    viewModel.fetchSwimmings()
                                    
                                    withAnimation(.spring()) {
                                        
                                        viewModel.isDetail = true
                                    }
                                    
                                }, label: {
                                    
                                    HStack {
                                        
                                        Text(index.hisOPlace ?? "")
                                            .foregroundColor(.black)
                                            .font(.system(size: 18, weight: .semibold))
                                            .padding(.horizontal)
                                        
                                        VStack(alignment: .leading, spacing: 12) {
                                            
                                            Text(index.hisTitle ?? "")
                                                .foregroundColor(.black)
                                                .font(.system(size: 18, weight: .semibold))
                                            
                                            Text(index.hisPlace ?? "")
                                                .foregroundColor(.black)
                                                .font(.system(size: 16, weight: .regular))
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        
                                        Image(systemName: "arrow.up.right")
                                            .foregroundColor(.black)
                                            .font(.system(size: 18, weight: .semibold))
                                            .padding(.horizontal)

                                    }
                                })
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 15).fill(.white))
                    }
                }
            }
            .padding()
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            AddHistory(viewModel: viewModel)
        })
        .sheet(isPresented: $viewModel.isDetail, content: {
            
            hHisDetail(viewModel: viewModel)
        })
        .onAppear{
            
            viewModel.fetchHistories()
        }
        .onAppear{
            
            viewModel.fetchSwimmings()
        }
    }
}

#Preview {
    ResultsView()
}
