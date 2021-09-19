//
//  CameraView.swift
//  PoliceRecorder
//
//  Created by Pranav on 9/18/21.
//

import Foundation
import SwiftUI

struct CameraView: UIViewControllerRepresentable{
    func makeUIViewController(context: UIViewControllerRepresentableContext<CameraView>) -> UIViewController{
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(identifier: "Camera")
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<CameraView>){
        
    }
}
