//
//  PlayPauseView.swift
//  AdaptrDemo
//
//  Created by Arveen kumar on 01/02/2021.
//

import SwiftUI
import Adaptr

struct SkipView: UIViewRepresentable {
    
    var pointSize:CGFloat = 24
    var weight: UIImage.SymbolWeight = .light
    
    func makeUIView(context: Context) -> SkipButton {
        let button = SkipButton()
        let homeSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: self.pointSize, weight:self.weight)
        let skip = UIImage(systemName: "forward.fill", withConfiguration:homeSymbolConfiguration)
        button.setImage(skip, for: [])
        return button
       }

    func updateUIView(_ uiView: SkipButton, context: Context) {
    }
}

struct SkipView_Previews: PreviewProvider {
    static var previews: some View {
        SkipView()
    }
}
