//
//  ViewModifiersCustom.swift
//  PoliceRecorder
//
//  Created by Pranav on 9/18/21.
//

import Foundation
import SwiftUI
import SwiftSpeech


public extension SwiftSpeech.ViewModifiers {
    /**
     `viewComponentState` will never be `.cancelling` here.
     */
    struct RecordOnAppear : ViewModifier {
        public init(sessionConfiguration: SwiftSpeech.Session.Configuration = SwiftSpeech.Session.Configuration(), animation: Animation = SwiftSpeech.defaultAnimation) {
            self.sessionConfiguration = sessionConfiguration
            self.animation = animation
        }
        
        var sessionConfiguration: SwiftSpeech.Session.Configuration
        var animation: Animation
        
        @SpeechRecognitionAuthStatus var authStatus
        

        @State var recordingSession: SwiftSpeech.Session? = nil
        @State var viewComponentState: SwiftSpeech.State = .pending
        
        var delegate = SwiftSpeech.FunctionalComponentDelegate()
        
       /* var gesture: some Gesture {
            TapGesture()
                .onEnded {
                    withAnimation(self.animation) {
                        if self.viewComponentState == .pending {  // if not recording
                            self.startRecording()
                        } else {  // if recording
                            self.endRecording()
                        }
                    }
                }
        }*/
        
        public func body(content: Content) -> some View {
            content
                .onAppear{
                    withAnimation(self.animation) {
                        if self.viewComponentState == .pending {  // if not recording
                            self.startRecording()
                        } else {  // if recording
                            self.endRecording()
                        }
                    }
                }
                //.gesture(gesture, including: $authStatus ? .gesture : .none)
                .environment(\.swiftSpeechState, viewComponentState)
        }
        
        fileprivate func startRecording() {
            let id = SpeechRecognizer.ID()
            let session = SwiftSpeech.Session(id: id, configuration: sessionConfiguration)
            // View update
            self.viewComponentState = .recording
            self.recordingSession = session
            delegate.onStartRecording(session: session)
            session.startRecording()
        }
        
        fileprivate func endRecording() {
            guard let session = recordingSession else { preconditionFailure("recordingSession is nil in \(#function)") }
            recordingSession?.stopRecording()
            delegate.onStopRecording(session: session)
            self.viewComponentState = .pending
            self.recordingSession = nil
        }
        
    }
    
}
