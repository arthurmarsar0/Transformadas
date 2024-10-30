//
//  ListView.swift
//  Transformadas
//
//  Created by Alice Barbosa on 29/10/24.
//

import SwiftUI

struct ListView: View {
    var body: some View {
        VStack{
            ScrollView(.vertical){
                
                ListComponent()
                ListComponent()
                ListComponent()
                ListComponent()
                ListComponent()
                ListComponent()
                ListComponent()
                ListComponent()
                ListComponent()
            }
            
            //TODO: Adicionar lógica pra ForEach service in services etc com cloudkit e cada componente ser um botão que abre uma sheet
        }.padding()
    }
}

#Preview {
    ListView()
}
