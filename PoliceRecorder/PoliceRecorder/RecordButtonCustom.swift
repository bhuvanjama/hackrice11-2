//
//  RecordButtonCustom.swift
//  PoliceRecorder
//
//  Created by Pranav on 9/18/21.
//

import SwiftUI
import Combine
import SwiftSpeech


public extension SwiftSpeech.RecordButton {
    struct RecordButtonCustom : View {
        
        @Environment(\.swiftSpeechState) var state: SwiftSpeech.State
        @SpeechRecognitionAuthStatus var authStatus
        
        public init() { }
        
        var backgroundColor: Color {
            switch state {
            case .pending:
                return .red
            case .recording:
                return .red
            case .cancelling:
                return .red
            }
        }
        
        public var body: some View {
            
            ZStack {
                backgroundColor
                    .animation(.easeOut(duration: 0.2))
                    .clipShape(Circle())
                    .environment(\.isEnabled, $authStatus)  // When isEnabled is false, the accent color is gray and all user interactions are disabled inside the view.
                    .zIndex(0)
                
                Image(systemName: "xmark")
                    .font(.system(size: 20, weight: .medium, design: .default))
                    .foregroundColor(.white)
                    .opacity(state == .recording ? 0.8 : 1.0)
                    .transition(.opacity)
                    .layoutPriority(2)
                    .zIndex(1)
            }
               
        }
        
    }
}


