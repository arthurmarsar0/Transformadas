//
//  PhotoAlbumView.swift
//  Transformadas
//
//  Created by Arthur Alves Marsaro on 07/11/24.
//

import SwiftUI

struct PhotoAlbumView: View {
    @State private var paginationOffset: Int?
    var body: some View {
        ZStack{
            Color.bege
                .ignoresSafeArea()
            VStack {
                HStack{
                    Text("Minhas Fotos")
                        .font(.system(size: 28, weight: .regular))
                        .foregroundStyle(.marrom)
                    Spacer()
                }
                ScrollView{
                    PaginatedView( paginationOffset: $paginationOffset) { entradas in
                        ForEach(entradas) { entrada in
                            VStack{
                                Text(entrada.photo!)
                            }
                            .customOnAppear(false) {
                                if entradas.last == entrada {
                                    print("Fetch")
                                }
                            }
                        }
                        
                    }
                }
                .onAppear{
                    if paginationOffset == nil {
                        paginationOffset = 0
                    }
                }
                
            }
            .padding()
        }
    }
    
    func showMore() {
        
    }
}

#Preview {
    PhotoAlbumView()
}



