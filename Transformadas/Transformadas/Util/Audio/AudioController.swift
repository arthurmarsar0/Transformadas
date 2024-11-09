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


////essa classe controla a reprodução do áudio
//class AudioPlayer: NSObject, ObservableObject {
//    var audioPlayer: AVAudioPlayer!
//    @Published var isPlaying = false
//    //faz basicamente o que o método do controle da gravação faz
//    func startPlayback(audio: URL) {
//        let playbackSession = AVAudioSession.sharedInstance()
//        
//        do {
//            try playbackSession.overrideOutputAudioPort(.speaker)
//            audioPlayer = try AVAudioPlayer(contentsOf: audio)
//            audioPlayer.delegate = self
//            audioPlayer.play()
//            isPlaying = true
//        } catch {
//            print("Erro ao iniciar a reprodução")
//        }
//    }
//    
//    func stopPlayback() {
//        audioPlayer.stop()
//        isPlaying = false
//    }
//}
//
//extension AudioPlayer: AVAudioPlayerDelegate {
//    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
//        if flag {
//            isPlaying = false
//        }
//    }
//}


func getFileDate(for file: URL) -> Date {
    if let attributes = try? FileManager.default.attributesOfItem(atPath: file.path) as [FileAttributeKey: Any],
        let creationDate = attributes[FileAttributeKey.creationDate] as? Date {
        return creationDate
    } else {
        return Date()
    }
}

//essa classe controla a gravação do audio
//class RecordController: NSObject, ObservableObject, AVAudioPlayerDelegate {
//    
//    var audioRecorder: AVAudioRecorder! //variável que controla o funcionamento da gravação
//    var audioPlayer: AVAudioPlayer!
//    
//    @Published var isRecording: Bool = false
//    
//    func beginRecording(date: Date) {
//        //uma sessão de gravação de audio
//        let session = AVAudioSession.sharedInstance()
//        
//        do {
//            //tenta setar a gravação
//            try session.setCategory(.playAndRecord, mode: .default)
//            try session.setActive(true)
//        } catch {
//            print("Não pode iniciar a gravação")
//        }
//        
//        //isso daqui eu so copiei, como o usuario vai poder nomear os arquivos salvos de audio a gnt vai ter que mudar
//        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//        let fileName = path.appendingPathComponent("Audio\(date.dayMonthYear).m4a")
//        
//        //criar as configurações da gravação
//        let settings = [
//          AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
//          AVSampleRateKey: 12000,
//          AVNumberOfChannelsKey: 1,
//          AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
//        ]
//        
//        //verificar se houver erro
//        do {
//            audioRecorder = try AVAudioRecorder(url: fileName, settings: settings)
//            audioRecorder.prepareToRecord()
//            isRecording = true
//        }
//        catch {
//            print("Falhou em setar a gravação")
//        }
//        
//    }
//    
//    func endRecording() -> Audio {
//        let audio = Audio(name: "", path: audioRecorder.url)
//        audioRecorder.stop()
//        isRecording = false
//        //self.fetchAllRecords()
//        
//        return audio
//    }
//
////    func fetchAllRecords()  {
////        
////        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
////        
////        let directoryContents = try! FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
////        
////        for i in directoryContents {
////            records.append(Audio(name: <#T##String#>, path: <#T##URL#>))
////            records.append(Audio(fileURL : i, createdAt:getFileDate(for: i), isPlaying: false))
////        }
////        //deixa os records por ordem cronologica
////        records.sort(by: { $0.createdAt.compare($1.createdAt) == .orderedDescending})
////        
////    }
//
//}

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

            let tempDirectory = FileManager.default.temporaryDirectory
            let audioURL = tempDirectory.appendingPathComponent("Audio\(Date.now.dayMonthYear).m4a")

            audioRecorder = try AVAudioRecorder(url: audioURL, settings: settings)
            audioRecorder?.isMeteringEnabled = true
            audioRecorder?.record()

            startUpdatingAudioLevel()
            isRecording = true
            
            recordedAudio = Audio(name: "", path: audioURL, length: 0.0)
        } catch {
            print("Erro ao iniciar a gravação: \(error.localizedDescription)")
        }
    }

    func stopRecording() -> Audio? {
        recordedAudio?.length = audioDuration
        audioRecorder?.stop()
        stopUpdatingAudioLevel()
        isRecording = false
    
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
