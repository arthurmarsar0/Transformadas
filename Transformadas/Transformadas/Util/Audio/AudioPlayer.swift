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
    public var currentTime: TimeInterval? {
        audioPlayer?.currentTime
    }
    
    // Método para iniciar a reprodução de áudio
    func startPlayback(audio: URL) {
        let playbackSession = AVAudioSession.sharedInstance()
        
        do {
            // Configura a sessão de áudio para reprodução
            try playbackSession.setCategory(.playback, mode: .default)
            try playbackSession.setActive(true, options: .notifyOthersOnDeactivation)

            // Se o player já estiver em uso, pare e crie uma nova instância
            if audioPlayer != nil {
                audioPlayer?.stop()
            }
            
            // Inicializa o AVAudioPlayer com o arquivo de áudio
            audioPlayer = try AVAudioPlayer(contentsOf: audio)
            audioPlayer?.delegate = self
            audioPlayer?.prepareToPlay()  // Garante que o áudio está pronto para ser reproduzido
            audioPlayer?.play()
            
            isPlaying = true
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
}

extension AudioPlayer: AVAudioPlayerDelegate {
    // Método chamado quando a reprodução do áudio termina
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            isPlaying = false
        }
        
        // Libera a instância do player após a reprodução terminar
        audioPlayer = nil
    }
}
