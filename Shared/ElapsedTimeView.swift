//
//  PlayPauseView.swift
//  AdaptrDemo
//
//  Created by Arveen kumar on 01/02/2021.
//

import SwiftUI
import Adaptr

struct ElapsedTimeView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ElapsedTimeLabel {
        let label = ElapsedTimeLabel()
        label.textForNoTime = "0:00"
        return label
       }

    func updateUIView(_ uiView: ElapsedTimeLabel, context: Context) {
        
    }
}

struct ElapsedTimeView_Previews: PreviewProvider {
    static var previews: some View {
        ElapsedTimeView()
    }
}
