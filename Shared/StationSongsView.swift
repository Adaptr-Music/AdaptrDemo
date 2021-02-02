//
//  StationSongsView.swift
//  AdaptrDemo
//
//  Created by Arveen kumar on 27/01/2021.
//

import SwiftUI
import Foundation
import Adaptr


struct StationSongsView: View {
    
    var currentStation:ContentView.Stations

    struct Songs: Identifiable {
        let id: String
        let name: String
        let imageUrl:URL
        let file:Audiofile
    }
    
    @ObservedObject var viewModel: ViewModelSongs
    
    init(currentStation:ContentView.Stations) {
        self.currentStation = currentStation
        self.viewModel = ViewModelSongs(id:self.currentStation.id)
    }

    var body: some View {
        
            List (viewModel.songs) { (song: Songs) in
                NavigationLink(destination: PlayerView(file:song.file)){
                
                    HStack(){
                        AsyncImage(
                           url: song.imageUrl,
                           placeholder: { Text(" ") },
                            image: { Image(uiImage: $0).resizable()  }
                        )
                        .frame(width: 64, height: 64).aspectRatio(contentMode: .fit)
                        
                    Text(song.name)
                    }
                    
                
                }.navigationBarTitle(currentStation.name)
            }
        .onAppear {
            if(viewModel.songs.isEmpty) {
                viewModel.loadTracks()
            }
        }
    }

    class ViewModelSongs: ObservableObject {
        init(id: String) {
            self.stationID = id
        }
        var stationID:String

        @Published private(set) var songs: [Songs] = []

        let player:AdaptrAudioPlayer = AdaptrAudioPlayer.shared()
        func loadTracks() {
            player.whenAvailable({ [self] in
                
                player.requestTracks(forStation: stationID, pageNo: 0, resultsPerPage: 100) { (files:Array<Audiofile>?) in
                    
                    for file in files! {
                        let urlSt = file.metadata["artwork150x150"] as! String
                        let url = URL(string: urlSt)
                        songs.append(Songs(id:file.id, name: file.name, imageUrl: (url ??  URL(string:""))!, file: file ))
                    }
                }
            })
            { }
        }
    }
    
}


struct StationSongsView_Previews: PreviewProvider {
    static var previews: some View {
        StationSongsView(currentStation: ContentView.Stations(id: "is", name: "demo"))
    }
}
