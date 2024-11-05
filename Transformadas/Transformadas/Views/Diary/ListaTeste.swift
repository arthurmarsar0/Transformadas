//
//  ListaTeste.swift
//  Transformadas
//
//  Created by Arthur Alves Marsaro on 30/10/24.
//

import SwiftUI

struct ListaTeste: View {
    var body: some View {
        List {
            Section{
                HStack{
                    Circle()
                        .frame(width: 40)
                        .onTapGesture {
                            print("a")
                        }

                    Circle()
                        .fill(Color.red)
                        .frame(width: 40)
                        .overlay(content: {
                            Text("😀")
                        })
                        .onTapGesture {
                            print("b")
                        }
                        
                }
                .listRowBackground(Color.clear)
                
            }
            
            Section("oii") {
                Text("OI")
            }
        }
    }
}

#Preview {
    ListaTeste()
}
