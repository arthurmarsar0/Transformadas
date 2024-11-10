//
//  AudioPlayer.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 06/11/24.
//

import AVFoundation
import SwiftUI

class AudioPlayer: NSObject, ObservableObject {
    var audioPlayer: AVAudioPlayer?
    @Published var isPlaying = false
    @Published var isStarted = false
    //@Published var audio: Audio?
    @Published var currentTime: TimeInterval = 0.0
    
//    public var currentTime: TimeInterval {
//        audioPlayer?.currentTime ?? audio?.length ?? 0.0
//    }
    
    // Método para iniciar a reprodução de áudio
    func startPlayback(audio: Audio) {
        //self.audio = audio
        
        let playbackSession = AVAudioSession.sharedInstance()
        
        do {
            // Configura a sessão de áudio para reprodução
            try playbackSession.setCategory(.playback, mode: .default)
            try playbackSession.setActive(true, options: .notifyOthersOnDeactivation)

            // Se o player já estiver em uso, pare e crie uma nova instância
            if audioPlayer != nil {
                audioPlayer?.stop()
            }
                
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: audio.url)
                audioPlayer?.delegate = self
                audioPlayer?.prepareToPlay()  // Garante que o áudio está pronto para ser reproduzido
                audioPlayer?.play()
                startTimer()
                
                isPlaying = true
                isStarted = true
            } catch {
                print("Erro ao tentar reproduzir o áudio: \(error.localizedDescription)")
            }
            
            
        } catch {
            print("Erro ao iniciar a reprodução: \(error)")
        }
    }
    
    // Método para parar a reprodução de áudio
    func stopPlayback() {
        // Verifica se o player foi inicializado antes de tentar parar a reprodução
        guard let player = audioPlayer else {
            print("Player não foi inicializado")
            return
        }
        
        player.stop()
        isPlaying = false
        isStarted = false
    }
    
    func pausePlayback() {
        // Verifica se o player foi inicializado antes de tentar parar a reprodução
        guard let player = audioPlayer else {
            print("Player não foi inicializado")
            return
        }
        
        player.pause()
        isPlaying = false
    }
    
    func playPlayback() {
        // Verifica se o player foi inicializado antes de tentar parar a reprodução
        guard let player = audioPlayer else {
            print("Player não foi inicializado")
            return
        }
        
        player.play()
        isPlaying = true
    }
    
    private func startTimer() {
            let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
                guard let self = self else { return }
                if let current = self.audioPlayer?.currentTime {
                    DispatchQueue.main.async {
                        self.currentTime = current
                    }
                }
            }
        }
}

extension AudioPlayer: AVAudioPlayerDelegate {
    // Método chamado quando a reprodução do áudio termina
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            isPlaying = false
            isStarted = false
        }
        
        // Libera a instância do player após a reprodução terminar
        audioPlayer = nil
    }
}
