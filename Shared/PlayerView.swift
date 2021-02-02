//
//  PlayerView.swift
//  AdaptrDemo
//
//  Created by Arveen kumar on 27/01/2021.
//

import SwiftUI
import Adaptr

struct PlayerView: View {
    

    @ObservedObject var viewModel: ViewModelSongDetail
    
    init(file:Audiofile) {
        self.viewModel = ViewModelSongDetail(file:file)
    }

    
    var body: some View {
        VStack() {
            AsyncImage(
               url: viewModel.audioFileImage,
               placeholder: { Text("") },
               image: { Image(uiImage: $0).resizable()  }
            )
            .frame(width:UIScreen.main.bounds.width-40, height:UIScreen.main.bounds.width-40).aspectRatio(contentMode: .fit).padding(20)
            Spacer()
            MarqueeText(text:viewModel.audioFile.name+" by "+viewModel.audioFile.artist).frame(width:UIScreen.main.bounds.width-40 , height: 40, alignment: .leading).accentColor(.black)
            AudioProgressBar().accentColor(.black).padding()
            HStack() {
                ElapsedTimeView().accentColor(.black).frame(width:40, alignment: .leading)
                Spacer()
                RemainingTimeView().accentColor(.black).frame(width:40, alignment: .trailing)
            }.padding().frame(height: 30)
            HStack(){
                PlayPauseView(pointSize:24).accentColor(.black)
                SkipView(pointSize: 24).accentColor(.black)
            }.frame(height: 30)
            
            
        }
        .onAppear {
            self.viewModel.playTrack()
        }
    }
    
    
    class ViewModelSongDetail: ObservableObject {
        
        let player:AdaptrAudioPlayer = AdaptrAudioPlayer.shared()
        init(file: Audiofile) {
            self.audioFile = file
            let urlSt = file.metadata["artwork640"] as! String
            let url = URL(string: urlSt)
            audioFileImage = url!
        }
        
        @Published private(set) var audioFile:Audiofile
        @Published private(set) var audioFileImage:URL
        
        
        func playTrack() {
            NotificationCenter.default.addObserver( self, selector: #selector(self.itemChanged), name: NSNotification.Name.AdaptrAudioPlayerCurrentItemDidBeginPlayback, object: nil)
            //NotificationCenter.default.addObserver( self, selector: #selector(self.stateChanged), name: NSNotification.Name.AdaptrAudioPlayerPlaybackStateDidChange, object: nil)
            
            player.whenAvailable({ [self] in
                player.loadAudioItems([audioFile], withCrossfade: false)
                player.play()
                
                
                
            })
            { }
        }
        
        /*
        @objc func stateChanged(notification:NSNotification)  {
            var state:String = ""
            switch self.player.playbackState {
            case AdaptrAudioPlayerPlaybackState.playing, AdaptrAudioPlayerPlaybackState.stalled, AdaptrAudioPlayerPlaybackState.requestingSkip, AdaptrAudioPlayerPlaybackState.waitingForItem:
                state = "PAUSE"
                
            default:
                state = "PLAY"
            }
        }
        */
        
        
        @objc func itemChanged(notification:NSNotification)  {
            
            self.audioFile = self.player.currentItem ?? self.audioFile//+" - "+(self.player.currentItem?.artist ?? "")
            let urlSt = audioFile.metadata["artwork640"] as! String
            let url = URL(string: urlSt)
            self.audioFileImage = url!
        }
    }

    
    
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(file: Audiofile(json: "{\"id\": \"721362\", \"duration_in_seconds\": 356,\"track\": {\"id\": \"15953844\",\"title\": \"Keep My Cool (Franky Rizardo Intro Edit)\"},\"release\": {\"id\": \"1742363\",\"title\": \"Defected Presents Franky Rizardo In The House (Mixed)\"},\"artist\": {\"id\": \"1265920\",\"name\": \"Franky Rizardo\"},\"extra\": {\"artwork150x150\": \"https://media.adaptr.com/image/api/150x150/release/1742363/72980.jpg\",\"artwork640\": \"https://media.adaptr.com/image/api/640x640/fit-in/release/1742363/72980.jpg\"}}"))
    }
}
