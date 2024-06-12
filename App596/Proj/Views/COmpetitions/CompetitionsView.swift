//
//  CompetitionsView.swift
//  App596
//
//  Created by IGOR on 01/06/2024.
//

import SwiftUI

struct CompetitionsView: View {
    
    @StateObject var viewModel = CompetitionsViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 15) {
                
                HStack {
                    
                    Text("Competitions")
                        .foregroundColor(.white)
                        .font(.system(size: 26, weight: .bold))
                    
                    Spacer()
                    
                    Button(action: {
                        
                        withAnimation(.spring())
                        {
                            
                            viewModel.isAddCompetition = true
                        }
                    }, label: {
                        
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .semibold))
                    })
                }
                .padding(.bottom)
                
                if viewModel.competitions.isEmpty {
                    
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
                        
                        LazyVStack(spacing: 12) {
                            
                            ForEach(viewModel.competitions, id: \.self) { index in
                                
                                Button(action: {
                                    
                                    viewModel.selectedCompetition = index
                                    
                                    withAnimation(.spring()) {
                                        
                                        viewModel.isDetail = true
                                    }
                                    
                                }, label: {
                                    
                                    HStack {
                                        
                                        Image(index.compPhoto ?? "")
                                            .resizable()
                                            .frame(width: 150, height: 150)
                                            .cornerRadius(15)
                                        
                                        VStack(alignment: .leading, spacing: 12) {
                                            
                                            Text(index.compName ?? "")
                                                .foregroundColor(.black)
                                                .font(.system(size: 16, weight: .medium))
                                            
                                            Spacer()
                                            
                                            Text(index.compDate ?? "")
                                                .foregroundColor(.white)
                                                .font(.system(size: 11, weight: .regular))
                                                .padding(4)
                                                .padding(.horizontal, 3)
                                                .background(RoundedRectangle(cornerRadius: 5).fill(Color("prim")))
                                            
                                            Text(index.compPlace ?? "")
                                                .foregroundColor(.gray)
                                                .font(.system(size: 14, weight: .regular))
                                        }
                                        .padding()
                                        
                                        Spacer()
                                    }
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 150)
                                    .background(RoundedRectangle(cornerRadius: 15).fill(.white))
                                })
                            }
                        }
                    }
                }
                
                Spacer()
            }
            .padding()
        }
        .overlay(
            
            ZStack {
                
                Color.black.opacity(viewModel.isAddCompetition ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAddCompetition = false
                        }
                    }
                
                VStack {
                    
                    HStack {
                        
                        Spacer()
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAddCompetition = false
                            }
                            
                        }, label: {
                            
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .font(.system(size: 15, weight: .regular))
                        })
                    }
                    
                    Text("Add competitions")
                        .foregroundColor(.black)
                        .font(.system(size: 16, weight: .medium))
                        .padding()
                    
                    Menu(content: {
                        
                        ForEach(viewModel.photos, id: \.self) { index in
                            
                            Button(action: {
                                
                                viewModel.currentPhoto = index
                                
                            }, label: {
                                
                                Image(index)
                            })
                            
                        }
                        
                    }, label: {
                        
                        if viewModel.currentPhoto.isEmpty {
                            
                            Image(systemName: "photo")
                                .foregroundColor(Color("prim"))
                                .frame(maxWidth: .infinity)
                                .frame(height: 180)
                                .background(RoundedRectangle(cornerRadius: 15).stroke(Color("prim")))
                                .padding(1)
                            
                        } else {
                            
                            Image(viewModel.currentPhoto)
                        }
                        
                    })
                    
                    ZStack(alignment: .leading, content: {
                        
                        Text("Name")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .opacity(viewModel.compName.isEmpty ? 1 : 0)
                        
                        TextField("", text: $viewModel.compName)
                            .foregroundColor(Color.black)
                            .font(.system(size: 16, weight: .semibold))
                        
                    })
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(RoundedRectangle(cornerRadius: 5).stroke(Color("prim")))
                    .padding(1)
                    
                    ZStack(alignment: .leading, content: {
                        
                        Text("Date")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .opacity(viewModel.compDate.isEmpty ? 1 : 0)
                        
                        TextField("", text: $viewModel.compDate)
                            .foregroundColor(Color.black)
                            .font(.system(size: 16, weight: .semibold))
                        
                    })
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(RoundedRectangle(cornerRadius: 5).stroke(Color("prim")))
                    .padding(1)
                    
                    ZStack(alignment: .leading, content: {
                        
                        Text("Place")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .opacity(viewModel.compPlace.isEmpty ? 1 : 0)
                        
                        TextField("", text: $viewModel.compPlace)
                            .foregroundColor(Color.black)
                            .font(.system(size: 16, weight: .semibold))
                        
                    })
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(RoundedRectangle(cornerRadius: 5).stroke(Color("prim")))
                    .padding(1)
                    
                    HStack {
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAddCompetition = false
                            }
                            
                        }, label: {
                            
                            Text("Cancel")
                                .foregroundColor(Color("prim"))
                                .font(.system(size: 18, weight: .regular))
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(RoundedRectangle(cornerRadius: 15).stroke(Color("prim")))
                                .padding(1)
                            
                        })
                        
                        Button(action: {
                            
                            viewModel.compPhoto = viewModel.currentPhoto
                            
                            viewModel.addCompetition()
                            
                            viewModel.compName = ""
                            viewModel.compDate = ""
                            viewModel.compPlace = ""
                            
                            viewModel.fetchCompetitions()
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAddCompetition = false
                                
                            }
                            
                        }, label: {
                            
                            Text("Add")
                                .foregroundColor(.white)
                                .font(.system(size: 18, weight: .semibold))
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(RoundedRectangle(cornerRadius: 15).fill(Color("prim")))
                                .padding(1)
                            
                        })
                        .opacity(viewModel.compName.isEmpty || viewModel.compDate.isEmpty || viewModel.compPlace.isEmpty || viewModel.currentPhoto.isEmpty ? 0.5 : 1)
                        .disabled(viewModel.compName.isEmpty || viewModel.compDate.isEmpty || viewModel.compPlace.isEmpty || viewModel.currentPhoto.isEmpty ?  true : false)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
                .padding()
                .offset(y: viewModel.isAddCompetition ? 0 : UIScreen.main.bounds.height)
            }
        )
        .overlay(
            
            ZStack {
                
                Color.black.opacity(viewModel.isDetail ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isDetail = false
                        }
                    }
                
                VStack {
                    
                    HStack {
                        
                        Spacer()
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isDetail = false
                            }
                            
                        }, label: {
                            
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .font(.system(size: 15, weight: .regular))
                        })
                    }
                    
                    Text(viewModel.selectedCompetition?.compName ?? "")
                        .foregroundColor(.black)
                        .font(.system(size: 16, weight: .medium))
                        .padding()
                    
                    Image(viewModel.selectedCompetition?.compPhoto ?? "")
                    
                    Text(viewModel.selectedCompetition?.compName ?? "")
                        .foregroundColor(.black)
                        .font(.system(size: 14, weight: .regular))
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 5).stroke(Color("prim")))
                        .padding(1)
                    
                    Text(viewModel.selectedCompetition?.compDate ?? "")
                        .foregroundColor(.black)
                        .font(.system(size: 14, weight: .regular))
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 5).stroke(Color("prim")))
                        .padding(1)
                    
                    Text(viewModel.selectedCompetition?.compPlace ?? "")
                        .foregroundColor(.black)
                        .font(.system(size: 14, weight: .regular))
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 5).stroke(Color("prim")))
                        .padding(1)
                    
                    HStack {
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isDelete = true
                            }
                            
                        }, label: {
                            
                            Text("Delete")
                                .foregroundColor(Color("prim"))
                                .font(.system(size: 18, weight: .regular))
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(RoundedRectangle(cornerRadius: 15).stroke(Color("prim")))
                                .padding(1)
                            
                        })
                        
                        Button(action: {
                            
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isDetail = false
                                
                            }
                            
                        }, label: {
                            
                            Text("Back")
                                .foregroundColor(.white)
                                .font(.system(size: 18, weight: .semibold))
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(RoundedRectangle(cornerRadius: 15).fill(Color("prim")))
                                .padding(1)
                            
                        })
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
                .padding()
                .offset(y: viewModel.isDetail ? 0 : UIScreen.main.bounds.height)
            }
        )
        .overlay(
            
            ZStack {
                
                Color.black.opacity(viewModel.isDelete ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isDelete = false
                        }
                    }
                
                VStack {
                    
                    HStack {
                        
                        Spacer()
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isDelete = false
                            }
                            
                        }, label: {
                            
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .font(.system(size: 15, weight: .regular))
                        })
                    }
                    
                    Text("Delete")
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .semibold))
                        .padding()
                    
                    Text("Are you sure you want to delete?")
                        .foregroundColor(.black)
                        .font(.system(size: 14, weight: .regular))
                        .multilineTextAlignment(.center)
                    
                    Button(action: {
                        
                        
                        CoreDataStack.shared.deleteCompetition(withCompName: viewModel.selectedCompetition?.compName ?? "", completion: {
                            
                            viewModel.fetchCompetitions()
                        })
                        
          
                        withAnimation(.spring()) {
                            
                            viewModel.isDelete = false
                            viewModel.isDetail = false
                            
                        }
                                
                    }, label: {
                        
                        Text("Delete")
                            .foregroundColor(.black)
                            .font(.system(size: 18, weight: .semibold))
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                        
                    })
                    .padding(.top, 25)
                    
                    Button(action: {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isDelete = false
                        }
                        
                    }, label: {
                        
                        Text("Close")
                            .foregroundColor(.red)
                            .font(.system(size: 18, weight: .regular))
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                        
                    })
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
                .padding()
                .offset(y: viewModel.isDelete ? 0 : UIScreen.main.bounds.height)
            }
        )
        .onAppear {
            
            viewModel.fetchCompetitions()
        }
    }
}

#Preview {
    CompetitionsView()
}
