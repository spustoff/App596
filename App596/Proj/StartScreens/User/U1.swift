//
//  U1.swift
//  App596
//
//  Created by IGOR on 01/06/2024.
//

import SwiftUI

struct U1: View {
    var body: some View {

        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            VStack {
                
                Image("U1")
                    .resizable()
                    .ignoresSafeArea()
            }
            
            VStack {
                
                Spacer()
                
                VStack {
                    
                    Text("Play and win with us")
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
                            
                            Reviews()
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
                .frame(height: 190)
                .background(RoundedRectangle(cornerRadius: 15).fill(.white))
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    U1()
}
