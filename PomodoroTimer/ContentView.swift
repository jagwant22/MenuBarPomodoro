//
//  ContentView.swift
//  PomodoroTimer
//
//  Created by Jagwant Sehgal on 3/24/21.
//

import SwiftUI
import AVFoundation
struct ContentView: View {
    @State var timeRemaining = 2;
    @State var currentDate = Date()
    @State var soundPlayed = false
    @State var audioPlayer = AVAudioPlayer()
    @State var audioPlayerInit = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func initAudioPlayer() {
        do {
        
        if let fileURL = Bundle.main.path(forResource: "ting", ofType: "mp3") {
            self.audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileURL), fileTypeHint: "mp3")
            audioPlayerInit = true;
            print("Continue processing")
        } else {
            print("Error: No file with specified name exists")
        }
        
        }catch let err{
            print(err)
        }
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> String {
        let times:(Int, Int, Int) = (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
        return "\(times.1) : \(times.2)"
    }
    
    var body : some View {
        
        VStack {
            Text("Pomodoro : Jagwant Sehgal")
                .padding(.top)
            Text("Time Left : \(secondsToHoursMinutesSeconds(seconds: timeRemaining))").frame(maxWidth: 150, maxHeight: 100).onReceive(timer){ _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                }
                if timeRemaining == 0 && soundPlayed == false {
                    // play ting
                    initAudioPlayer()
                    print("Audio player init ")
                    self.audioPlayer.play()
                    print("Audio play")
                    soundPlayed = true
                }
                
            }
            HStack{
                Button("Start/Reset") {
                    timeRemaining = 1500
                    soundPlayed = false
                }
                Button("Stop") {
                    timeRemaining = 0
                    soundPlayed = true
                }
                Button("Quit") {
                    print("Stop")
                    exit(0)
                }
                
            }
            .padding([.leading, .bottom, .trailing])
            
        }
        
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
