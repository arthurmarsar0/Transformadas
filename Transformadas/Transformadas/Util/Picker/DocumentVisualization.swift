//
//  DocumentVisualization.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 09/11/24.
//

import Foundation
import QuickLook
import SwiftUI

//class DocumentOpener: NSObject, UIDocumentInteractionControllerDelegate {
//    private var documentInteractionController: UIDocumentInteractionController?
//
//    func openDocument(at url: URL, from viewController: UIViewController) {
////        guard url.startAccessingSecurityScopedResource() else {
////            print("Não foi possível acessar a URl de forma segura (abrindo documento)")
////            return
////        }
//        documentInteractionController = UIDocumentInteractionController(url: url)
//        documentInteractionController?.delegate = self
//        documentInteractionController?.presentOptionsMenu(from: viewController.view.bounds, in: viewController.view, animated: true)
//        
//        //url.stopAccessingSecurityScopedResource()
//    }
//}

class DocumentOpener: NSObject, QLPreviewControllerDataSource {
    var documentURL: URL?

    func openDocument(at url: URL, from viewController: UIViewController) {
        documentURL = url
        
        let previewController = QLPreviewController()
        previewController.dataSource = self
        viewController.present(previewController, animated: true, completion: nil)
    }
    
    // QLPreviewControllerDataSource methods
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1 // Um arquivo para preview
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return documentURL! as QLPreviewItem
    }
}

extension UIApplication {
    var firstKeyWindow: UIWindow? {
        // 1
        let windowScenes = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
        // 2
        let activeScene = windowScenes
            .filter { $0.activationState == .foregroundActive }
        // 3
        let firstActiveScene = activeScene.first
        // 4
        let keyWindow = firstActiveScene?.keyWindow
        
        return keyWindow
    }
}
