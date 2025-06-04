//
//  SignIn.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 10/11/24.
//

import SwiftUI
import AuthenticationServices
import SwiftData

struct SignIn: View {
    @State var sucesso: Bool = false
    @State var hadUser: Bool = false
    @State var navigate: Bool = false
    
    @EnvironmentObject var appData: AppData
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.bege.ignoresSafeArea()
                VStack (alignment: .center, spacing: 16){
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundStyle(.verdeMedio)
                    Text("Configurar dados de perfil")
                        .font(.system(size: 28, weight: .bold))
                    Text("Primeiro, entre ou cadastre-se usando seu Apple ID!")
                        .font(.system(size: 15, weight: .regular))
                        .foregroundStyle(.cinzaEscuro)
                    
                    Spacer()
                    
                    TelaAppleID(sucesso: $sucesso, hadUser: $hadUser)
                        .frame(height: 50)
                        .environmentObject(appData)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                //.padding(.top, 24)
            }.onChange(of: sucesso) {
                if sucesso && !hadUser {
                    navigate = true
                }
            }.navigationDestination(isPresented: $navigate) {
                OnboardingData()
                    .navigationBarBackButtonHidden()
                    .environmentObject(appData)
            }.toolbar {
                ToolbarItem(placement: .automatic) {
                    Text("")
                }
            }
        }
    }
}

struct TelaAppleID: View {
    
    @EnvironmentObject var appData: AppData
    @Binding var sucesso: Bool
    @Binding var hadUser: Bool
    @Query var users: [User]
    
    var body: some View {
        SignInWithAppleButton(.signUp) { request in
            request.requestedScopes = [.fullName, .email]
        } onCompletion: { result in
            switch result {
            case .success(let authorization):
                if let userCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
                    sucesso = true
                    appData.appleID = userCredential.user
                    
                    if users.contains(where: {$0.modelID == appData.appleID}) {
                        appData.primeiraAbertura = true
                        hadUser = true
                    }
                    
                    
                }
            case .failure(let error):
                print("Could not authenticate: \(error.localizedDescription)")
            }
        }
    }
}
