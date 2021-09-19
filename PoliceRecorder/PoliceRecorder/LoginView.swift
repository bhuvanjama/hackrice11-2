//
//  LoginView.swift
//  PoliceRecorder
//
//  Created by Siddharth on 9/17/21.
//
import Foundation
import SwiftUI

struct Home: View {
    @State var isShow = false
    var body: some View{
        NavigationView{
//            ZStack{
//                NavigationLink(
//                    destination: RegistrationView(),
//                    isActive: self.$isShow,
//                    label: {
//
//                        Text("")
//                    }).hidden()
//
//                LoginView()
//
//            }
        }
    }
}

struct LoginView: View {
    
    @State var user = ""
    @State var pass = ""

    
    var body: some View {
        
        NavigationView {
        ZStack {
            LinearGradient(gradient: .init(colors: [Color("1"), Color("1")]), startPoint: .leading, endPoint: .trailing).edgesIgnoringSafeArea(.all)
            
            VStack {
                
                //@bhuvan - i need the logo !!
                Image("Aura").resizable().frame(width: 200, height: 200).padding(.bottom, 15)
                
                HStack {
                    Image(systemName: "person").resizable().frame(width: 20, height: 20).foregroundColor(.black)
                    TextField("Username", text: $user).padding(.leading, 12).font(.system(size: 20)).foregroundColor(.red)
                }.padding(12)
                .background(Color.white)
                .cornerRadius(20)
                
                HStack {
                    Image(systemName: "lock").resizable().frame(width: 15, height: 20).padding(.leading, 3).foregroundColor(.black)
                    SecureField("Password", text: $pass).padding(.leading, 12).font(.system(size: 20)).foregroundColor(.red)
                }.padding(12)
                .background(Color.white)
                .cornerRadius(20)
                .offset(y: 15)
                
                Button(action: {
                    
                    //call sign in func
                    
                    let auth: AuthBackend = AuthBackend()
                    auth.loginAuth(username: user, password: pass)
                    
                    //@pranav - add nav link here to menu page
                    
                }, label: {
                    Text("Sign In").foregroundColor(.white).padding()
                }).frame(width: 150, alignment: .center)
                .cornerRadius(20)
                .offset(y: 15)
                .padding(2)
                //register button
                NavigationLink(destination: RegistrationView()) {
                    Text("Create an ACCOUNT").foregroundColor(.white).padding()
                }.frame(width: 250, alignment: .center)
                .cornerRadius(20)
                .offset(y: 15)
                .padding(1)
                
//                Button(action: {
//                    //@pranav - add a nav link here to the registration page
//
//                }, label: {
//                    Text("Create an Account").foregroundColor(.white).padding()
//                }).frame(width: 250, alignment: .center)
//                .cornerRadius(20)
//                .offset(y: 15)
//                .padding(1)
                
            }
            .padding(.horizontal, 18)
        }

    }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
