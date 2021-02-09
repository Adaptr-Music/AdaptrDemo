//
//  PlayerView.swift
//  AdaptrDemo
//
//  Created by Arveen kumar on 27/01/2021.
//

import SwiftUI
import Adaptr
import Combine

struct PlayerView: View {
    

    @ObservedObject var viewModel: ViewModelSongDetail
    
    init(file:Audiofile, files:Array<Audiofile>) {
        self.viewModel = ViewModelSongDetail(file:file, files:files)
    }

   // let pub = NotificationCenter.default.publisher(for: NSNotification.Name(AdaptrAudioPlayerCurrentItemDidBeginPlayback))


    struct Song: Identifiable {
        let id: String
        let name: String
        let artist: String
        let album: String
        let imageUrl:URL
    }
    
    var body: some View {
        VStack() {
            AsyncImage(
               url: viewModel.song.imageUrl,
                placeholder: { Text(viewModel.song.artist) },
               image: { Image(uiImage: $0).resizable()  }
            )
            .frame(width:UIScreen.main.bounds.width-40, height:UIScreen.main.bounds.width-40).aspectRatio(contentMode: .fit).padding(20)
            Spacer()
            VStack(alignment: .center, spacing: 0) {
                Text(viewModel.song.name).frame(width:UIScreen.main.bounds.width-40, alignment: .center).lineLimit(1)
                Text(viewModel.song.artist).frame(width:UIScreen.main.bounds.width-40 , alignment: .center).lineLimit(1)
                Text(viewModel.song.album).frame(width:UIScreen.main.bounds.width-40 , alignment: .center).lineLimit(1)

            }
            AudioProgressBar().accentColor(.black).padding()
            HStack() {
                ElapsedTimeView().accentColor(.black).frame(width:40, alignment: .leading)
                Spacer()
                RemainingTimeView().accentColor(.black).frame(width:40, alignment: .trailing)
            }.padding().frame(height: 30)
            
            HStack(alignment: .center, spacing: 60){
                Button(action: {
                    viewModel.player.previous()}) {
                            Image(systemName: "backward.fill")
                            .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                }.accentColor(.black).frame(width: 30, height: 30)
                PlayPauseView(pointSize:24).accentColor(.black).frame(width: 30, height: 30)
                SkipView(pointSize: 24).accentColor(.black).frame(width: 30, height: 30)
            }.frame( height: 40 ,alignment: .bottom)
            
        }
        .onAppear {
            self.viewModel.subscribe()
        }
    }
    
    
    class ViewModelSongDetail: ObservableObject {
        
        let player:AdaptrAudioPlayer = AdaptrAudioPlayer.shared()
        var index:UInt = 0
        //var mfile:Audiofile;
        //var mfiles:Array<Audiofile>
        
        init(file:Audiofile, files:Array<Audiofile>) {
            let urlSt = file.metadata["artwork640"] as! String
            let url = URL(string: urlSt)
            song = Song(id: file.id, name: file.name, artist: file.artist, album: file.album , imageUrl:url! )
            let mindex = files.firstIndex(of: file) ?? 0
            index = UInt(mindex)
        }
        
        @Published private(set) var song:Song
        
        func subscribe() {
            NotificationCenter.default.addObserver( self, selector: #selector(self.itemChanged), name: NSNotification.Name.AdaptrAudioPlayerCurrentItemDidBeginPlayback, object: nil)
            NotificationCenter.default.addObserver( self, selector: #selector(self.stateChanged), name: NSNotification.Name.AdaptrAudioPlayerPlaybackStateDidChange, object: nil)
            
            player.play(from:index)
            
        }
        
        // To modify play pasue buttone manually
        @objc func stateChanged(notification:NSNotification)  {
            var state:String = ""
            switch self.player.playbackState {
            case AdaptrAudioPlayerPlaybackState.playing, AdaptrAudioPlayerPlaybackState.stalled, AdaptrAudioPlayerPlaybackState.requestingSkip, AdaptrAudioPlayerPlaybackState.waitingForItem:
                state = "PAUSE"
                
            default:
                state = "PLAY"
            }
        }
        
        // Item is changed
        @objc func itemChanged(notification:NSNotification)  {
            
            let audioFile = self.player.currentItem
            if(audioFile != nil){
                let urlSt = audioFile!.metadata["artwork640"] as! String
                let url = URL(string: urlSt)
                song = Song(id: audioFile!.id, name: audioFile!.name, artist: audioFile!.artist, album: audioFile!.album, imageUrl:url! )
                
            }
        }

    }

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(file:Audiofile(), files:[])
    }
}


}
