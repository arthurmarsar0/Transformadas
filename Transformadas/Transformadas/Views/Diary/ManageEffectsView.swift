//
//  ManageEffectsView.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 05/11/24.
//

import SwiftUI
import SwiftData

struct ManageEffectsView: View {
    // MARK: - EXTERNAL
    @Binding var hasEffectsChanged: Bool
    
    // MARK: - DATA
    @Query var effects: [Effect]
    @Environment(\.modelContext) var modelContext
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - VIEW DATA
    @State var customEffects: [Effect] = []
    @State var activeEffects: [Effect] = []
    @State var inactiveEffects: [Effect] = []
    @State var newEffects: [Effect] = []
    @State var removedEffects: [Effect] = []
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.cinzaMuitoClaro
                    .ignoresSafeArea()
                
                List {
                    Section (content: {
                        ForEach($customEffects) { $effect in
                            TextField("", text: $effect.name)
                                
                        }.onDelete(perform: deleteEffect)
                        
                        ForEach($newEffects) { $effect in
                            
                            TextField("Novo Efeito", text: $effect.name)
                                
                            
                        }.onDelete(perform: deleteNewEffect)
                        
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("Adicione um Efeito")
                        }.foregroundStyle(.green)
                        .onTapGesture {
                            withTransaction(Transaction(animation: .default)) {
                                newEffects.append(Effect(name: "", status: .custom))
                            }
                        }
                    }, header: {
                        Text("MEUS EFEITOS")
                    }, footer: {
                        Text("Crie ou remova efeitos personalizados")
                    })
                    
                    Section(content: {
                        ForEach(activeEffects) { effect in
                            Text(effect.name)
                                .swipeActions (edge: .trailing) {
                                    Button (action: {
                                        withTransaction(Transaction(animation: .default)) {
                                            //effect.status = .inactive
                                            activeEffects = activeEffects.filter({$0.modelID != effect.modelID})
                                            inactiveEffects.append(effect)
                                        }
                                    }){
                                        Label("Desativar", systemImage: "folder.fill.badge.minus")
                                    }.tint(.red)
                                }
                        }
                    }, header: {
                        Text("EFEITOS PADRÃO ATIVOS")
                    })
                    
                    Section("EFEITOS PADRÃO INATIVOS") {
                        ForEach(inactiveEffects) { effect in
                            Text(effect.name)
                                .swipeActions (edge: .trailing){
                                    Button (action: {
                                        withTransaction(Transaction(animation: .default)) {
                                            //effect.status = .active
                                            inactiveEffects = inactiveEffects.filter({$0.modelID != effect.modelID})
                                            activeEffects.append(effect)
                                        }
                                    }){
                                        Label("Ativar", systemImage: "folder.fill.badge.plus")
                                    }.tint(.green)
                                }
                        }
                    }
                }
            }.onAppear {
                customEffects = effects.filter({$0.status == .custom})
                activeEffects = effects.filter({$0.status == .active})
                inactiveEffects = effects.filter({$0.status == .inactive})
            }.toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Cancelar")
                    }
                    
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
                        for effect in newEffects {
                            modelContext.insert(effect)
                        }
                        for effect in activeEffects {
                            effect.status = .active
                        }
                        for effect in inactiveEffects {
                            effect.status = .inactive
                        }
                        for effect in removedEffects {
                            modelContext.delete(effect)
                        }
                        hasEffectsChanged = true
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Salvar")
                    }
                }
            }
            .scrollContentBackground(.hidden)
                .modifier(KeyboardDismiss())
        }.onAppear {
            removeNavBarBackground()
        }
    }
    
    // MARK: - DATA FUNC
    
    func deleteEffect(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                removedEffects.append(customEffects[index])
            }
            customEffects.remove(atOffsets: offsets)
        }
    }
    
    func deleteNewEffect(offsets: IndexSet) {
        withAnimation {
            newEffects.remove(atOffsets: offsets)
        }
    }
}
