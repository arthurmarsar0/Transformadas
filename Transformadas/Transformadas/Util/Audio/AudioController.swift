//
//  Audio.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 02/11/24.
//

import Foundation
import SwiftUI
import AVFoundation
import SwiftData


func getFileDate(for file: URL) -> Date {
    if let attributes = try? FileManager.default.attributesOfItem(atPath: file.path) as [FileAttributeKey: Any],
        let creationDate = attributes[FileAttributeKey.creationDate] as? Date {
        return creationDate
    } else {
        return Date()
    }
}

class AudioRecorder: ObservableObject {
    private var audioRecorder: AVAudioRecorder?
    private var timer: Timer?

    @Published var audioLevel: CGFloat = 0.0 // Nível de áudio para a visualização da onda
    @Published var isRecording: Bool = false
    
    var recordedAudio: Audio?
    
    public var audioDuration: TimeInterval {
        audioRecorder?.currentTime ?? 0.0
    }

    func startRecording() {
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default, options: .defaultToSpeaker)
            try audioSession.setActive(true)

//            let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//            let audioURL = path.appendingPathComponent("Audio\(Date.now.dayMonthYear).m4a")
            
            let tempDirectory = FileManager.default.temporaryDirectory
            let audioURL = tempDirectory.appendingPathComponent("Audio\(Date.now.dayMonthYear).m4a")

            audioRecorder = try AVAudioRecorder(url: audioURL, settings: settings)
            audioRecorder?.isMeteringEnabled = true
            audioRecorder?.record()

            startUpdatingAudioLevel()
            isRecording = true
            
            recordedAudio = Audio(name: "", data: Data(), length: 0.0)
        } catch {
            print("Erro ao iniciar a gravação: \(error.localizedDescription)")
        }
    }

    func stopRecording() -> Audio? {
        recordedAudio?.length = audioDuration
        
        audioRecorder?.stop()
        stopUpdatingAudioLevel()
        isRecording = false
        
        do {
            if let url = audioRecorder?.url {
                let data = try Data(contentsOf: url)
                recordedAudio?.data = data
            }
        } catch {
            print("Erro ao salvar áudio para Data: \(error.localizedDescription)")
        }

        return recordedAudio
    }

    private func startUpdatingAudioLevel() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
            self.audioRecorder?.updateMeters()
            if let averagePower = self.audioRecorder?.averagePower(forChannel: 0) {
                let normalizedLevel = self.normalizeAudioLevel(level: averagePower)
                DispatchQueue.main.async {
                    self.audioLevel = normalizedLevel
                }
            }
        }
    }

    private func stopUpdatingAudioLevel() {
        timer?.invalidate()
        timer = nil
    }

    private func normalizeAudioLevel(level: Float) -> CGFloat {
        // Normaliza o nível de áudio de -160 dB a 0 dB para uma escala de 0 a 1
        let level = max(0.2, CGFloat(level + 160) / 160)
        return level
    }
}
