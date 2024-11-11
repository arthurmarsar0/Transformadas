//
//  DocumentPicker.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 05/11/24.
//

import SwiftUI
import UIKit
import UniformTypeIdentifiers

struct DocumentPicker: UIViewControllerRepresentable {
    @Binding var selectedURL: URL?
    @Environment(\.presentationMode) var presentationMode
    
    // Os tipos de arquivos que você deseja permitir, pode ser ajustado conforme necessário
    var documentTypes: [String] = ["public.text", "public.image", "com.adobe.pdf"]

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: documentTypes.compactMap { UTType($0) })
        picker.delegate = context.coordinator
        picker.allowsMultipleSelection = false // Defina se o usuário pode selecionar múltiplos arquivos
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}
    
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var parent: DocumentPicker
        
        init(parent: DocumentPicker) {
            self.parent = parent
        }
        
        // Quando o usuário seleciona um arquivo
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            
            if let selectedURL = urls.first {
                guard selectedURL.startAccessingSecurityScopedResource() else { // Notice this line right here
                     return
                }
                parent.selectedURL = selectedURL
                
                selectedURL.stopAccessingSecurityScopedResource()
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        // Caso o usuário cancele a seleção
        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

func saveDocumentToAppDirectory(url: URL) -> URL? {
    guard url.startAccessingSecurityScopedResource() else {
        return nil
    }
    
    let fileManager = FileManager.default
    let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
    let destinationURL = documentsDirectory.appendingPathComponent(url.lastPathComponent)

    do {
        if !fileManager.fileExists(atPath: destinationURL.path) {
            try fileManager.copyItem(at: url, to: destinationURL)
        }
        url.stopAccessingSecurityScopedResource()
        return destinationURL
    } catch {
        print("Erro ao salvar o documento: \(error.localizedDescription)")
        return nil
    }
    
    
}

func moveToiCloudDrive(localURL: URL) -> URL? {
    // O diretório no iCloud onde você deseja salvar o arquivo
    let iCloudDirectory = FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appendingPathComponent("Documents")
    
    // Verificar se o diretório do iCloud existe
    guard let iCloudDirectory = iCloudDirectory else {
        print("Erro: Não foi possível acessar o iCloud Drive.")
        return nil
    }

    // Criar o URL do arquivo no iCloud Drive com o mesmo nome do arquivo local
    let destinationURL = iCloudDirectory.appendingPathComponent(localURL.lastPathComponent)
    
    do {
        guard localURL.startAccessingSecurityScopedResource() else {
            print("Erro: Não foi possível acessar o URL de forma segura")
            return nil
        }
        // Verificar se o arquivo já existe no iCloud
        if FileManager.default.fileExists(atPath: destinationURL.path) {
            print("Arquivo já existe no iCloud (mas veio do iPhone pelo picker)")
            return destinationURL
        }
        
        // Copiar o arquivo para o iCloud Drive
        try FileManager.default.copyItem(at: localURL, to: destinationURL)
        
        localURL.stopAccessingSecurityScopedResource()
        
        // Arquivo foi movido com sucesso para o iCloud
        print("arquivo movido com sucesso para o iCloud")
        return destinationURL
        
    } catch {
        print("Erro ao mover o arquivo para o iCloud: \(error.localizedDescription)")
        return nil
    }
}

func isFileInICloud(fileURL: URL) -> Bool {
    guard let iCloudDirectory = FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appendingPathComponent("Documents") else {
        // Não foi possível acessar o iCloud
        print("Não foi possível acessar o iCloud (função bool)")
        return false
    }
    print("url do arquivo do picker: \(fileURL.absoluteString)")
    print("url do icloud: \(iCloudDirectory.absoluteString)")
    // Verifique se o arquivo está no diretório do iCloud
    return fileURL.absoluteString.hasPrefix(iCloudDirectory.absoluteString)
}

/*
 url do arquivo do picker: file:///private/var/mobile/Library/Mobile%20Documents/com~apple~CloudDocs/Sistema%20Integrado%20de%20Gesta%CC%83o%20de%20Atividades%20Acade%CC%82micas.pdf
 url do icloud: file:///private/var/mobile/Library/Mobile%20Documents/iCloud~br~ufpe~cin~pvom~Transformadas/Documents/
 arquivo não está no icloud
 Arquivo já existe no iCloud (mas veio do iPhone pelo picker)
 */
