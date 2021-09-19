//
//  HomeView.swift
//  PoliceRecorder
//
//  Created by Pranav on 9/17/21.
//

import SwiftUI
import CoreData
import AVKit
import SwiftSpeech
import Firebase

struct HomeView: View {
    
    @State var record = false
    @State var session: AVAudioSession!
    @State var recorder: AVAudioRecorder!
    @State var alert = false
    
    // fetch audio
    @State var audios: [URL] = []
    
    var storageAudios: [Any] = []
    
    let email = Auth.auth().currentUser?.email?.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")

    
    let storage = Storage.storage().reference()
    
    func startRecording() {
        do {
            
            if self.record {
                Circle().stroke(Color.white, lineWidth: 6).frame(width: 85, height: 85)
            } else{
                Circle().frame(width: 85, height: 85)
            }
            
            if self.record {
                
                //recording already in progress
//                self.recorder?.stop()
                self.record.toggle()
                //updating data for each rcd
                self.getAudios()
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
            
            self.recorder?.record()
            self.record.toggle()
            
            UIScreen.main.wantsSoftwareDimming = true
            UIScreen.main.brightness = 0
            
            
            let metadata = StorageMetadata()
            metadata.contentType = "audio/m4a"
                                        
            let vidRef = storage.child("recordings").child(email ?? "hello-gmail-com").child("myPoliceRcd_\(self.audios.count + 1).m4a")
            do {
                let audioData = try Data(contentsOf: (recorder?.url ?? URL(string: "https://www.google.com"))!)
                vidRef.putData(audioData, metadata: metadata) { (data, error) in
                    if error == nil {
                        vidRef.downloadURL { url, error in
                            guard let downloadURL = url else { return }
                        }
                    } else {
                        if let error = error?.localizedDescription {
                            print(error)
                        } else {
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
            
            
            
        } catch {
            print("Error occurred: " + error.localizedDescription)
        }
    }
    
    var body: some View {
        
        NavigationView {
            
            VStack{
                
                VStack {
                    
                    /*List(self.audios, id: \.self) { i in
                     
                     Text(i.relativeString)
                     }*/
                    
                    List{
                        ForEach(self.audios.indices, id: \.self){ i in
                            Button(action: {
                                //open mp4 file
                            }, label: {
                                Text(self.audios[i].relativeString)
                            })
                        }
                        .onDelete(perform: self.deleteAudios)
                    }
                    
                    Button(action: {
                        
                        startRecording()
                        
                    }, label: {
                        
                        ZStack {
                            Circle().fill(Color.blue).frame(width: 70, height: 70)
                            
                            
                            if self.record {
                                Circle().fill(Color.blue).frame(width: 70, height: 70)
                            }
                            
                        }
                        
                    })
                    .padding(.vertical, 25)
                }
                .navigationBarTitle("Record Audio")
                
                SwiftSpeech.Demos.Basic.BasicCustom(localeIdentifier: "en_US")
                
            }//VStack
            
            
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
            
            print(audios[index])
            
//            let str = (audios[index].absoluteString).range(of: "m4a")
//            string.removeSubrange(str!.upperBound..<string.endIndex)
            
            var string = audios[index].absoluteString
            print("file: " + string)
            let endOfName = string.firstIndex(of: "-")!
            let file = string[...(endOfName)]
            print("string: " + file)
                        
            let index = string.index(after: string.lastIndex(of: "/")!)..<string.endIndex
            print(index)

            
            
            
//            let fileRef = storage.child("recordings/").child(email!).child(audios[index])
            
        })
    }
}
