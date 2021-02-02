//
//  PlayPauseView.swift
//  AdaptrDemo
//
//  Created by Arveen kumar on 01/02/2021.
//

import SwiftUI
import Adaptr

struct RemainingTimeView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> RemainingTimeLabel {
        let label = RemainingTimeLabel()
        label.textForNoTime = "0:00"
        return label
       }

    func updateUIView(_ uiView: RemainingTimeLabel, context: Context) {
        
    }
}

struct RemainingTimeView_Previews: PreviewProvider {
    static var previews: some View {
        RemainingTimeView()
    }
}
