//
//  R1.swift
//  App596
//
//  Created by IGOR on 01/06/2024.
//

import SwiftUI

struct R1: View {
    var body: some View {

        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            VStack {
                
                Image("R1")
                    .resizable()
                    .ignoresSafeArea()
            }
            
            VStack {
                
                Spacer()
                
                VStack {
                    
                    Text("Convenient functionality and ease of learning")
                        .foregroundColor(.black)
                        .font(.system(size: 30, weight: .bold))
                        .multilineTextAlignment(.center)
                    
                    HStack {
                        
                        Spacer()
                        
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.black)
                            .frame(width: 40, height: 5)
                        
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.black.opacity(0.2))
                            .frame(width: 40, height: 5)
                        
                        Spacer()
                        
                        NavigationLink(destination: {
                            
                            R2()
                                .navigationBarBackButtonHidden()
                            
                        }, label: {
                            
                            Text("Next")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .regular))
                                .frame(width: 160, height: 50)
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color("prim")))
                        })
                    }
                    .frame(maxHeight: .infinity)

                }
                .padding(24)
                .frame(maxWidth: .infinity)
                .frame(height: 230)
                .background(RoundedRectangle(cornerRadius: 15).fill(.white))
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    R1()
}
