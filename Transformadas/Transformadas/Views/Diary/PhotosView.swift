//
//  PhotosView.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 31/10/24.
//

import SwiftUI

struct PhotosView: View {
    var entryDate: Date
    var photos: [Image]
    var startingPhoto: Int
    
    @State var selectedPhoto: Int = 0
    
    var body: some View {
        NavigationStack {
            
            TabView(selection: $selectedPhoto) {
                ForEach(0..<photos.count, id: \.self) { i in
                    photos[i]
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        //.scaledToFill()
                        //.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                        .clipped()
                        .tag(i)
                        
                }
            }
            .tabViewStyle(PageTabViewStyle())
            //.frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            
            
            
        }.toolbar {
            ToolbarItem(placement: .principal) {
                Text("\(entryDate.dayNumber) \(entryDate.monthString.prefix(3)) \(entryDate.yearNumber)")
                    .font(.system(size: 17, weight: .semibold))
            }
        }.onAppear {
            selectedPhoto = startingPhoto
        }
    }
}

#Preview {
    NavigationStack {
        PhotosView(entryDate: Date.now, photos: [Image(systemName: "calendar"), Image(systemName: "calendar"), Image(systemName: "calendar")], startingPhoto: 1)
    }
}
