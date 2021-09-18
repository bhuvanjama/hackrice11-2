//
//  DemosCustom.swift
//  PoliceRecorder
//
//  Created by Pranav on 9/18/21.
//
 
import SwiftUI
import Combine
import Speech
import SwiftSpeech
 
public extension SwiftSpeech.Demos.Basic{
    
    struct BasicCustom : View {
        
        var sessionConfiguration: SwiftSpeech.Session.Configuration
        
        @State var text = "Tap to Speak"
        
        public init(sessionConfiguration: SwiftSpeech.Session.Configuration) {
            self.sessionConfiguration = sessionConfiguration
        }
        
        public init(locale: Locale = .current) {
            self.init(sessionConfiguration: SwiftSpeech.Session.Configuration(locale: locale))
        }
        
        public init(localeIdentifier: String) {
            self.init(locale: Locale(identifier: localeIdentifier))
        }
        
        public var body: some View {
 
                VStack(spacing: 35.0) {
                    Text(text)
                        .font(.system(size: 20, weight: .thin, design: .default))
                    SwiftSpeech.RecordButton.RecordButtonCustom()
                        .swiftSpeechToggleRecordingOnTap(sessionConfiguration: sessionConfiguration, animation: .spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0))
                        .onRecognizeLatest(update: $text)
                    
                    if text.lowercased().range(of: "record audio") != nil{
                        HomeView(record: true)
                    }
                    
                }.onAppear {
                    SwiftSpeech.requestSpeechRecognitionAuthorization()
                }
            
        }
        
    }
}
