//
//  ContentView.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 25/10/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State var showSheet: Bool = false
    
    var body: some View {
        RegisterSheet(isPresented: $showSheet)
    }

}

#Preview {
    ContentView().modelContainer(for: [Effect.self])
}
