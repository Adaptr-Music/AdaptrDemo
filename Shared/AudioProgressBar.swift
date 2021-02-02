//
//  PlayPauseView.swift
//  AdaptrDemo
//
//  Created by Arveen kumar on 01/02/2021.
//

import SwiftUI
import Adaptr

struct AudioProgressBar: UIViewRepresentable {
    
    func makeUIView(context: Context) -> AudioProgressView {
        let button = AudioProgressView()
        
        return button
       }

    func updateUIView(_ uiView: AudioProgressView, context: Context) {
    }
}

struct AudioProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        AudioProgressBar()
    }
}
