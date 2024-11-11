//
//  SingleAudioView.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 10/11/24.
//

import SwiftUI

struct SingleAudioView: View {
    var audioDate: (Date, Audio)
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var tabViewModel: TabViewModel
    
    @EnvironmentObject var audioPlayer: AudioPlayer
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.beginho.ignoresSafeArea()
                VStack (spacing: 32){
                    Image(systemName: "waveform")
                    
                    VStack (spacing: 16) {
                        if audioPlayer.isStarted {
                            Text(audioPlayer.currentTime.minutesAndSeconds)
                        } else {
                            Text(audioDate.1.length.minutesAndSeconds)
                        }
                        
                        Button(action: {
                            if audioPlayer.isPlaying {
                                audioPlayer.pausePlayback()
                            } else {
                                if audioPlayer.isStarted {
                                    audioPlayer.playPlayback()
                                } else {
                                    audioPlayer.startPlayback(audio: audioDate.1)
                                }
                            }
                        }) {
                            Image(systemName: audioPlayer.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                                .foregroundStyle(.black)
                                .font(.system(size: 56))
                            
                            
                        }
                    }
                    
                    
                }
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }){
                            HStack{
                                Image(systemName: "chevron.left")
                                Text("Voltar")
                            }
                            .foregroundStyle(.preto)
                        }
                    }
                    ToolbarItem(placement: .principal) {
                        Text("\(audioDate.0.dayNumber) \(audioDate.0.monthString.prefix(3)) \(audioDate.0.yearNumber)")
                            .font(.system(size: 17, weight: .semibold))
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button(action: {
                            seeDay(date: audioDate.0)
                        }) {
                            Text("Ver Dia")
                                .foregroundStyle(.vermelho)
                        }
                    }
                }
                .toolbarBackground(.ultrathin)
                .toolbarBackgroundVisibility(.visible)
            }
        }
    }
    func seeDay(date: Date) {
        tabViewModel.selectedTab = 1
        tabViewModel.isShowingEntrySheet = true
        tabViewModel.selectedDate = date
    }
}
