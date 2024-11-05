//
//  CategoryFilter.swift
//  Transformadas
//
//  Created by Alice Barbosa on 04/11/24.
//

import SwiftUI

struct CategoryFilter: View {
    @Binding var selectedFilter: String
    @StateObject var viewModel = ServiceViewModel()
    @State var searchText: String = ""
    var body: some View {
        ScrollView(.horizontal){
            HStack{
                ForEach(Category.allCases, id: \.self){ category in
                    Button(action: {
                        selectedFilter = category.name
                        viewModel.filterServices(by: selectedFilter, searchText: searchText)
                    }){
                        ZStack{
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundStyle(selectedFilter == category.name ? .rosa : .cinzaMuitoClaro)
                                .frame(height: 32)
                            HStack(spacing: 8) {
                                if !category.symbol.isEmpty{
                                    Image(systemName: category.symbol)
                                        .foregroundColor(selectedFilter == category.name ? .white : category.color)
                                }
                                Text(category.name)
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(selectedFilter == category.name ? .white : .cinzaEscuro)
                            }.padding(.horizontal, 8)
                        }
                    }
                }
            }
        }
    }
}
