//
//  PlayPauseView.swift
//  AdaptrDemo
//
//  Created by Arveen kumar on 01/02/2021.
//

import SwiftUI
import Adaptr


/**
 * Wrap the play pasue view in 
 */
struct PlayPauseView: UIViewRepresentable {
    
    var pointSize:CGFloat = 24
    var weight: UIImage.SymbolWeight = .light
    
    func makeUIView(context: Context) -> PlayPauseButton {
        let button = PlayPauseButton()
        let homeSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: self.pointSize, weight:self.weight)
        let play = UIImage(systemName: "play.fill", withConfiguration:homeSymbolConfiguration)
        let pause = UIImage(systemName: "pause.fill",withConfiguration:homeSymbolConfiguration)
        button.setImage(play, for: [])
        button.setImage(pause, for: [.selected])
        return button
       }

    func updateUIView(_ uiView: PlayPauseButton, context: Context) {
        
    }
}

struct PlayPauseView_Previews: PreviewProvider {
    static var previews: some View {
        PlayPauseView()
    }
}
