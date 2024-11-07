//
//  AudioRecordingSheet.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 06/11/24.
//

import SwiftUI

struct AudioRecordingSheet: View {
    @State var timeElapsed: TimeInterval = 0.0
    @ObservedObject var audioRecorder: AudioRecorder
    
    @Binding var isShowingRecordAudioSheet: Bool
    @Binding var audio: Audio?
    
    var body: some View {
        
        if audioRecorder.isRecording {
            VStack {
                Text(audioRecorder.audioDuration.minutesAndSeconds)
                    .foregroundStyle(.cinzaEscuro)
                Spacer()
                HStack(spacing: 4) {
                    ForEach(0..<20, id: \.self) { i in
                        BarView(height: self.audioRecorder.audioLevel * CGFloat(i % 5 + 1))
                    }
                }
                .frame(height: 100)
                .animation(.easeOut(duration: 0.05), value: audioRecorder.audioLevel)
                
                Spacer()
                Button(action: {
                    audio = audioRecorder.stopRecording()
                    isShowingRecordAudioSheet = false
                }) {
                    Image(systemName: "stop.circle")
                        .foregroundStyle(.red)
                        .font(.system(size: 50))
                }
            }.padding(.vertical, 24)
        } else {
            VStack {
                Text(audioRecorder.audioDuration.minutesAndSeconds)
                    .foregroundStyle(.cinzaClaro)
                Spacer()
                Text("Iniciar Gravação de Áudio")
                    .foregroundStyle(.cinzaClaro)
                Spacer()
                Button(action: {
                    audioRecorder.startRecording()
                }) {
                    Image(systemName: "record.circle")
                        .foregroundStyle(.red)
                        .font(.system(size: 50))
                }
            }.padding(.vertical, 24)
        }
    }
    
}

struct BarView: View {
    var height: CGFloat

    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(Color.verde)
            .frame(width: 4, height: height)
    }
}
