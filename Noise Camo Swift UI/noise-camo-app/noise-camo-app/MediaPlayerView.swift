//
//  MediaPlayerView.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 16/05/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI
import AVKit

struct MediaPlayerView: View {
    
    
    @EnvironmentObject var eqSettings: EqualizerSettings
    
    @State var data: Data = .init(count: 0)
    @State var title = ""
//    @State private var playing = false
    @State private var width: CGFloat = 0
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            Image(uiImage: self.data.count == 0 ? UIImage(named: "earphone-background1")! : UIImage(data: self.data)!)
                .resizable()
                .frame(width: self.data.count == 0 ? 250 : nil, height: 250)
                .cornerRadius(15)
                
            Text(self.title)
                .font(.title)
                .foregroundColor(.white)
                .padding(.top)
            
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.white.opacity(0.6))
                    .frame(height: 8)
                Capsule()
                    .fill(Color.red)
                    .frame(width: self.width, height: 8)
            }.padding(.top)
            
            HStack(spacing: UIScreen.main.bounds.width / 5 - 30) {
                Button(action: {
                    
                }) {
                    Image(systemName: "backward.fill")
                        .font(.title)
                }
                Button(action: {
                    let decrease = self.eqSettings.audioPlayerNode.currentTime - 15
                    let duration = self.eqSettings.audioPlayerNode.duration(fileLength: Double(self.eqSettings.audioNodeFileLength))
                    
                    self.eqSettings.audioPlayerNode.seekTo(
                        value: Float((decrease > 0) ? decrease : 0),
                        audioFile: self.eqSettings.audioFile,
                        duration: Float(duration)
                    )
                }) {
                    Image(systemName: "gobackward.15")
                        .font(.title)
                }
                
                Button(action: {
                    if self.eqSettings.audioPlayerNode.isPlaying {
                        self.eqSettings.audioPlayerNode.pause()
                        self.eqSettings.playing = false
                    } else {
                        self.eqSettings.setBands(bands: self.eqSettings.equalizer.bands)
                        self.eqSettings.audioPlayerNode.play()
                        self.eqSettings.playing = true
                    }
                }) {
                    Image(systemName: self.eqSettings.playing ? "pause.fill" : "play.fill")
                        .font(.title)
                }
                
                Button(action: {
                    let increase = self.eqSettings.audioPlayerNode.currentTime + 15
                    
                    let duration = self.eqSettings.audioPlayerNode.duration(fileLength: Double(self.eqSettings.audioNodeFileLength))
                    
                    self.eqSettings.audioPlayerNode.seekTo(
                        value: Float((increase<duration) ? increase : duration),
                        audioFile: self.eqSettings.audioFile,
                        duration: Float(duration)
                    )
                }) {
                    Image(systemName: "goforward.15")
                        .font(.title)
                }
                
                Button(action: {
                    
                }) {
                    Image(systemName: "forward.fill")
                        .font(.title)
                }
            }
            .padding(.top, 25)
            .foregroundColor(.white)
         
        }
        .onAppear {
            self.eqSettings.getAudioFile(fileName: "song", fileType: "mp3")
            self.eqSettings.audioPlayerNode.scheduleFile(self.eqSettings.audioFile, at: nil, completionHandler: nil)
            
            self.eqSettings.audioEngine.prepare()
            do {
            try self.eqSettings.audioEngine.start()
            } catch _ {
                print("Something went wrong at equalization.")
            }
            self.getData()
            
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { (_) in
                if self.eqSettings.audioPlayerNode.isPlaying {
                    let screen = UIScreen.main.bounds.width - 30
                    let value = self.eqSettings.audioPlayerNode.currentTime / self.eqSettings.audioPlayerNode.duration(fileLength: Double(self.eqSettings.audioNodeFileLength))
                    self.width = screen * CGFloat(value)
                }
            }
        }
    }
    
    
    
    func getData() {
        let asset = AVAsset(url: self.eqSettings.audioFile.url)
        for i in asset.commonMetadata {
            if i.commonKey?.rawValue == "artwork" {
                let data = i.value as! Data
                self.data = data
            }
            if i.commonKey?.rawValue == "title" {
                let title = i.value as! String
                self.title = title
            }
        }
    }
}

struct MediaPlayerView_Previews: PreviewProvider {
    static let eqSettings = EqualizerSettings()
    static var previews: some View {
        NavigationView {
            MediaPlayerView()
                .environmentObject(eqSettings)
                .modifier(PageViewWrapper())
            .navigationBarTitle("Music Player")
        }
    }
}
