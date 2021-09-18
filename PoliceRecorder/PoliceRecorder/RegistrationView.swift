//
//  RegistrationView.swift
//  PoliceRecorder
//
//  Created by Bhuvan Jama on 9/18/21.
//

import SwiftUI
import Firebase

struct RegistrationView: View {
    @State var username = ""
    @State var password = ""
    @State var confirmPass = ""
    @State var phoneNumber = ""
    @State var email = ""
    // @Binding var isShow: Bool
    

    var body: some View {
        ZStack(alignment: .topLeading){
            Rectangle()
                .fill(Color(""))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            
            register
            
            Button(action: {
                // self.isShow.toggle()
            }, label: {
                Image(systemName: "chevron.left")
                    .font(.title)
                    .foregroundColor(.black)
                
            }).padding()
        }
        .navigationBarHidden(true)
        
    }

    var register: some View {
        
        ZStack{
            LinearGradient(gradient: .init(colors: [Color("1"), Color("1")]), startPoint: .leading, endPoint: .trailing).edgesIgnoringSafeArea(.all)

            
            VStack{
                
                Text("Welcome")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                Text("Log in to existing account")

                
                TextField("Username", text: $username)
                    .padding()
                    .cornerRadius(5)
                    .modifier(InnerShawdowViewModifier())
                    .padding(.bottom, 4)
                    .background(Color.white)
                    .cornerRadius(15)
                
                SecureField("Password", text: $password)
                    .padding()
                    .cornerRadius(5)
                    .modifier(InnerShawdowViewModifier())
                    .padding(.bottom, 4)
                    .background(Color.white)
                    .cornerRadius(15)
               
                SecureField("Confirm password", text: $confirmPass)
                    .padding()
                    .cornerRadius(5)
                    .modifier(InnerShawdowViewModifier())
                    .padding(.bottom, 4)
                    .background(Color.white)
                    .cornerRadius(15)
                
                TextField("Phone number", text: $phoneNumber)
                    .padding()
                    .cornerRadius(5)
                    .modifier(InnerShawdowViewModifier())
                    .padding(.bottom, 4)
                    .background(Color.white)
                    .cornerRadius(15)
                
                TextField("Email", text: $email)
                    .padding()
                    .cornerRadius(5)
                    .modifier(InnerShawdowViewModifier())
                    .padding(.bottom, 4)
                    .background(Color.white)
                    .cornerRadius(15)
               

                HStack{
                        Button(action: {
                            
                            Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                                
                                if(error != nil){
                                    print(error?.localizedDescription)
                                }else{
                                    
                                    print("sucessfully created user")
                                    let alert = UIAlertController(title: "User Created", message: "Your user was successfully registered.", preferredStyle: .alert)
                                    let action = UIAlertAction(title: "Cool", style: .default, handler:nil)
                                    alert.addAction(action)
                                }
                                
                                
                            }
                            
                        }, label: {
                        Spacer()
                        Text("create")
                            .font(.title)
                            .fontWeight(.bold)
                            
                        Spacer()
                        
                    })
                    .foregroundColor(.black.opacity(0.8))
                    .padding()
                    .background(Color("bgColor"))
                    .cornerRadius(10)
                    .modifier(ShawdowViewModifier())
                }.padding(.bottom, 16)
                
                HStack{
                    
                    Text("Already have an account?")
                        
                    Text("Sign In")
                        .foregroundColor(.black)
                        .fontWeight(.semibold)
                        .onTapGesture{
                            
                        }
                }
                     
            }.padding(30)
        }
    }
}

struct InnerShawdowViewModifier: ViewModifier{
    @State var radius: CGFloat = 10
    
    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: radius)
                    .stroke(Color("bgColor"), lineWidth: 4)
                    .shadow(color: Color("darkShadow"), radius: 4, x: 5, y: 5)
                    .clipShape(RoundedRectangle(cornerRadius: radius))
                    .shadow(color: Color("lightShadow"), radius: 4, x: -5, y: -5)
                    .clipShape(RoundedRectangle(cornerRadius: radius))


            )
    }
}

struct ShawdowViewModifier: ViewModifier{
    
    func body(content: Content) -> some View {
        content
            .shadow(color: Color("lightShadow"), radius: 8, x: -8, y: -8)
            .shadow(color: Color("darkShadow"), radius: 8, x: -8, y: -8)

        
    }
}

//struct RegistrationView_Previews: PreviewProvider {
//    static var previews: some View {
//        RegistrationView()
//    }
//}
