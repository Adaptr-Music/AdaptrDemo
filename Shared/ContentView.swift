//
//  ContentView.swift
//  Shared
//
//  Created by Arveen kumar on 07/01/2021.
//
//

import SwiftUI
import Foundation
import Adaptr

struct ContentView: View {



    struct Stations: Identifiable {
        let id: String
        let name: String
    }

    @ObservedObject var viewModel: ViewModelStations = ViewModelStations()

    var body: some View {
        NavigationView {
            List (viewModel.stations) { (station: Stations) in
                NavigationLink(destination: StationSongsView(currentStation:station)){
                Text(station.name)
                }.navigationBarTitle("Stations").accentColor(.black)
            }
        }
        .onAppear {
            viewModel.loadStations()
        }
    }

    class ViewModelStations: ObservableObject {
        @Published private(set) var stations: [Stations] = []

        let player:AdaptrAudioPlayer = AdaptrAudioPlayer.shared()
        func loadStations() {
            player.whenAvailable({ [self] in
                for item in player.stationList {
                    let st = item as! Station
                    stations.append(Stations(id: st.identifier, name: st.name))
                }
            })
            { }
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
