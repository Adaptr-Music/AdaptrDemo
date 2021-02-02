//
//  PlayPauseView.swift
//  AdaptrDemo
//
//  Created by Arveen kumar on 01/02/2021.
//

import SwiftUI
import Adaptr

struct MetadataView: UIViewRepresentable {
    
    var format:String
    
    func makeUIView(context: Context) -> MetadataLabel {
        let label = MetadataLabel()
        
        label.format = format
        return label
       }

    func updateUIView(_ uiView: MetadataLabel, context: Context) {
        
    }
}

struct MetadataView_Previews: PreviewProvider {
    static var previews: some View {
        MetadataView(format:"")
    }
}
