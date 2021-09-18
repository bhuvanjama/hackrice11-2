//
//  SpeechRecognitionView.swift
//  PoliceRecorder
//
//  Created by Pranav on 9/18/21.
//

import Foundation
import SwiftUI
import SwiftSpeech

struct SpeechRecognitionView: View {
    
    var body: some View{
        Group {
                SwiftSpeech.Demos.Basic(localeIdentifier: "en_US")
            }
            .onAppear {
            SwiftSpeech.requestSpeechRecognitionAuthorization()
        }
    }
}
