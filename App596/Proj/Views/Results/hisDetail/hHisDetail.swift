//
//  hHisDetail.swift
//  App596
//
//  Created by IGOR on 02/06/2024.
//

import SwiftUI

struct hHisDetail: View {
    
    @StateObject var viewModel: ResultsViewModel
    @Environment(\.presentationMode) var router
    
    var body: some View {
        
        ZStack {
            
            Color.white
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("Record")
                        .foregroundColor(.black)
                        .font(.system(size: 16, weight: .medium))
                        .padding()
                    
                    HStack {
                        
                        Button(action: {
                            
                            router.wrappedValue.dismiss()
                            
                        }, label: {
                            
                            Image(systemName: "chevron.left")
                                .foregroundColor(Color("prim"))
                                .font(.system(size: 18, weight: .regular))
                            
                            Text("Back")
                                .foregroundColor(Color("prim"))
                                .font(.system(size: 16, weight: .regular))
                        })
                        
                        Spacer()
                    }
                }
                .padding(.bottom)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 15) {
                        
                        Text(viewModel.selectedHistory?.hisTitle ?? "")
                            .foregroundColor(.black.opacity(0.3))
                            .font(.system(size: 14, weight: .regular))
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 10).stroke(Color("prim")))
                            .padding(1)

                        Text(viewModel.selectedHistory?.hisPlace ?? "")
                                .foregroundColor(.black.opacity(0.3))
                                .font(.system(size: 14, weight: .regular))
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .frame(height: 50)
                                .background(RoundedRectangle(cornerRadius: 10).stroke(Color("prim")))
                                .padding(1)
                                                    
                        Text(viewModel.selectedHistory?.hisOPlace ?? "")
                                .foregroundColor(.black.opacity(0.3))
                                .font(.system(size: 14, weight: .regular))
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .frame(height: 50)
                                .background(RoundedRectangle(cornerRadius: 10).stroke(Color("prim")))
                                .padding(1)
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            
                            LazyVStack {
                                
                                ForEach(viewModel.swimmings, id: \.self) { index in
                                    
                                    HStack {
                                        
                                        Text("\(index.swimName ?? "")")
                                            .foregroundColor(.black)
                                            .font(.system(size: 15, weight: .regular))
                                        
                                        Spacer()
                                        
                                        Text("\(index.swimRes ?? "")")
                                            .foregroundColor(.black)
                                            .font(.system(size: 15, weight: .regular))
                                    }
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 10).fill(.white.opacity(0.1)))
                                }
                            }
                            
                                Button(action: {
                                    
                                    withAnimation(.spring()) {
                                        
                                        viewModel.isAddSwim = true
                                    }
                                    
                                }, label: {
                                    
                                    HStack {
                                        
                                        Image(systemName: "plus")
                                            .foregroundColor(.black)
                                            .font(.system(size: 16, weight: .medium))
                                        
                                        Text("Add a swim")
                                            .foregroundColor(.black)
                                            .font(.system(size: 16, weight: .regular))
                                    }
                                    .padding(12)
                                    .padding(.horizontal)
                                    .background(RoundedRectangle(cornerRadius: 10).stroke(.white.opacity(0.4)))
                                    .padding(1)
                                })
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
                
                HStack {
                    
                    Button(action: {
                        
                        withAnimation(.spring()) {
                            
                            router.wrappedValue.dismiss()
                        }
                        
                        viewModel.currentHistory = ""
                        
                    }, label: {
                        
                        Text("Cancel")
                            .foregroundColor(Color("prim"))
                            .font(.system(size: 15, weight: .medium))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 10).stroke(Color("prim")))
                    })
                    
                    Button(action: {
                        
                        viewModel.currentHistory = viewModel.hisTitle
                        
                        viewModel.addHistory()
                        
                        viewModel.hisPlace = ""
                        
                        viewModel.hisOPlace = ""
                        
                        viewModel.fetchHistories()
                        
                        viewModel.currentHistory = ""
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAdd = false
                        }
                        
                    }, label: {
                        
                        Text("Save")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .medium))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color("prim")))
                    })
                    .opacity(viewModel.hisTitle.isEmpty || viewModel.hisPlace.isEmpty || viewModel.hisOPlace.isEmpty ? 0.5 : 1)
                    .disabled(viewModel.hisTitle.isEmpty || viewModel.hisPlace.isEmpty || viewModel.hisOPlace.isEmpty ? true : false)
                }
            }
            .padding()
        }
        .overlay(
            
            ZStack {
                
                Color.black.opacity(viewModel.isAddSwim ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAddSwim = false
                        }
                    }
                
                VStack {
                    
                    HStack {
                        
                        Spacer()
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAddSwim = false
                            }
                            
                        }, label: {
                            
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .font(.system(size: 15, weight: .regular))
                        })
                    }
                    
                    Text("Add a swim")
                        .foregroundColor(.black)
                        .font(.system(size: 16, weight: .medium))
                        .padding()
                    
                    ZStack(alignment: .leading, content: {
                        
                        Text("Name")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .opacity(viewModel.swimName.isEmpty ? 1 : 0)
                        
                        TextField("", text: $viewModel.swimName)
                            .foregroundColor(Color.black)
                            .font(.system(size: 16, weight: .semibold))
                        
                    })
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color("prim")))
                    .padding(1)
                    
                    ZStack(alignment: .leading, content: {
                        
                        Text("Result")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .opacity(viewModel.swimRes.isEmpty ? 1 : 0)
                        
                        TextField("", text: $viewModel.swimRes)
                            .foregroundColor(Color.black)
                            .font(.system(size: 16, weight: .semibold))
                        
                    })
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color("prim")))
                    .padding(1)
                    
                    HStack {
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAddSwim = false
                            }
                                                        
                        }, label: {
                            
                            Text("Cancel")
                                .foregroundColor(Color("prim"))
                                .font(.system(size: 18, weight: .regular))
                                .frame(maxWidth: .infinity)
                                .frame(height: 45)
                            
                        })
                        .background(RoundedRectangle(cornerRadius: 10).stroke(Color("prim")))
                        .padding(1)
                        
                        Button(action: {
                            
                            viewModel.curHis = viewModel.hisTitle
                            
                            viewModel.addSwim()
                            
                            viewModel.swimName = ""
                            viewModel.swimRes = ""
                            
                            viewModel.fetchSwimmings()
                                                        
                            withAnimation(.spring()) {
                                
                                viewModel.isAddSwim = false
                                
                            }
                            
                        }, label: {
                            
                            Text("Save")
                                .foregroundColor(.white)
                                .font(.system(size: 18, weight: .semibold))
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                            
                        })
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("prim")))
                        .padding(1)
                    }
                    .padding(.top)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
                .padding()
                .offset(y: viewModel.isAddSwim ? 0 : UIScreen.main.bounds.height)
            }
        )
        .onAppear {
            
            viewModel.fetchSwimmings()
        }
    }
}

#Preview {
    hHisDetail(viewModel: ResultsViewModel())
}
