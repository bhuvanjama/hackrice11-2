//
//  AudioRecorder.swift
//  PoliceRecorder
//
//  Created by Siddharth on 9/17/21.
//

import Foundation
import SwiftUI
import Combine
import AVFoundation

class AudioRecorder: ObservableObject {
    
    let objectWillChange = PassthroughSubject<AudioRecorder, Never>()
    
    var audioRecorder: AVAudioRecorder!
    
    var recording = false {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    
}
