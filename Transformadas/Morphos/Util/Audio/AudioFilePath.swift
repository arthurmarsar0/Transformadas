//
//  AudioFilePath.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 09/11/24.
//

import Foundation

func getAudioFilePath(audioPath: String) -> URL {
    let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    return path.appendingPathComponent(audioPath)
}

let fileName = UUID().uuidString + ".m4a"
let filePath = getAudioFilePath(audioPath: fileName)
