//
//  HomeView.swift
//  PoliceRecorder
//
//  Created by Pranav on 9/17/21.
//

import SwiftUI
import CoreData
import AVKit

struct HomeView: View {
    
    @State var record = false
    @State var session: AVAudioSession!
    @State var recorder: AVAudioRecorder!
    @State var alert = false
    
    // fetch audio
    @State var audios: [URL] = []
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                /*List(self.audios, id: \.self) { i in
                    
                    Text(i.relativeString)
                }*/
                
                List{
                    ForEach(self.audios.indices, id: \.self){ index in
                        Button(action: {
                            //open mp4 file
                        }, label: {
                            Text(self.audios[index].relativeString)
                        })
                    }
                    .onDelete(perform: self.deleteAudios)
                }
                
                Button(action: {
                    
                    do {
                        
                        if self.record {
                            
                            //recording already in progress
                            
                            self.recorder.stop()
                            self.record.toggle()
                            //updating data for each rcd
                            self.getAudios()
                            return
                        }
                    
                        
                    let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                        
                    let date = Date()
                    
                    let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "MM/dd/yyyy"
                    
                        let fileName = url.appendingPathComponent("myPoliceRcd-\(self.audios.count + 1).m4a")
                    
                    let settings = [
                        
                        AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                        AVSampleRateKey: 12000,
                        AVNumberOfChannelsKey: 1,
                        AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
                        
                    ]
                    
                    self.recorder = try AVAudioRecorder(url: fileName, settings: settings)
                    
                        self.recorder.record()
                        self.record.toggle()
                        
                } catch {
                    print("Error occurred: " + error.localizedDescription)
                }
                }, label: {
                    
                    ZStack {
                        Circle().fill(Color.red).frame(width: 70, height: 70)
           
                        
                        if self.record {
                            Circle().stroke(Color.white, lineWidth: 6).frame(width: 85, height: 85)
                        }
                    }
                    
                })
                .padding(.vertical, 25)
            }
            .navigationBarTitle("Record Audio")
        }
        .alert(isPresented: self.$alert, content: { () -> Alert in
            Alert(title: Text("Error"), message: Text("Please enable microphone access."))
        })
        .onAppear {
            
            do {
                self.session = AVAudioSession.sharedInstance()
                try session.setCategory(.playAndRecord)
                
                //request permission to record
                self.session.requestRecordPermission({ (status) in
                    
                    if !status {
                        
                        self.alert.toggle()
                        
                    } else {
                        
                        //fetch all data if permission granted
                        self.getAudios()
                        
                    }
                    
                })
            } catch {
                
            }
            
        }
    }
    
    func getAudios() {
        do {
            
            let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            
            let result = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .producesRelativePathURLs)
            
            //if updated, remove all old data
            self.audios.removeAll()
            
            for i in result {
                
                self.audios.append(i)
                
            }
            
        } catch {
            
            print("Error occurred: " + error.localizedDescription)
        }
    }
    
    func deleteAudios(with indexSet: IndexSet) {
        indexSet.forEach({index in
            //delete from firebase
        })
        }
}
