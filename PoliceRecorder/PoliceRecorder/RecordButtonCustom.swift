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
                return .black
            case .recording:
                return .black
            case .cancelling:
                return .black
            }
        }
        
        var scale: CGFloat {
            switch state {
            case .pending:
                return 1.0
            case .recording:
                return 1.8
            case .cancelling:
                return 1.4
            }
        }
        
        public var body: some View {
            
            ZStack {
                backgroundColor
                    .animation(.easeOut(duration: 0.2))
                    .clipShape(Circle())
                    .environment(\.isEnabled, $authStatus)  // When isEnabled is false, the accent color is gray and all user interactions are disabled inside the view.
                    .zIndex(0)
                
                
                
            }
                .scaleEffect(scale)
                .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.2), radius: 5, x: 0, y: 3)
               
        }
        
    }
}


