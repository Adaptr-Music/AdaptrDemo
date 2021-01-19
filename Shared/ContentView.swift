//
//  ContentView.swift
//  Shared
//
//  Created by Arveen kumar on 07/01/2021.
//
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                Text("Station 1")
                Text("Station 2")
            }.navigationBarTitle("Stations")
        }
    }
}

class ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }

    #if DEBUG
    @objc class func injected() {
        UIApplication.shared.windows.first?.rootViewController =
                UIHostingController(rootView: ContentView())
    }
    #endif
}
