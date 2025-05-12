//
//  RegisterView.swift
//  FindMyPet
//
//  Created by amir on 08.05.2025.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Binding var showRegister: Bool
    var body: some View {
        VStack {
            ZStack{
                Rectangle()
                    .frame(width: 410, height: 120)
                    .foregroundColor(Color(red: 188/255, green: 230/255, blue: 154/255))
                Text("FindMyPet")
                    .font(.largeTitle).bold()
                    .padding(.top, 30)
            }
            .ignoresSafeArea()
            
            Image("Main")
            Text("Sign up with email")
                .font(.system(size: 24, weight: .semibold))
                .padding()
            ZStack{
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.1))
                    .stroke(Color.gray, lineWidth: 1)
                    .frame(width: 358, height: 50)
                TextField("Email address", text: $authViewModel.email)
                    .keyboardType(.default)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .frame(width: 345)
                    .padding(.horizontal)
            }
            .padding()
            ZStack{
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.1))
                    .stroke(Color.gray, lineWidth: 1)
                    .frame(width: 358, height: 50)
                TextField("Nickname", text: $authViewModel.nickname)
                    .keyboardType(.default)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .frame(width: 345)
                    .padding(.horizontal)
            }
            .padding(.bottom)
            ZStack{
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.1))
                    .stroke(Color.gray, lineWidth: 1)
                    .frame(width: 358, height: 50)
                SecureField("Password", text: $authViewModel.password)
                    .frame(width: 345)
                    .padding()
            }
            Button(action:{
                authViewModel.signUp()
            }){
                ZStack{
                    RoundedRectangle(cornerRadius: 16)
                    //                        .stroke(Color.black, lineWidth: 2)
                        .foregroundColor(Color(red: 188/255, green: 230/255, blue: 154/255))
                        .overlay(RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.black, lineWidth: 1))
                        .frame(width:343, height:56)
                    Text("Sign up")
                        .foregroundColor(.black.opacity(0.6))
                        .font(.system(size: 20))
                }
                .padding()
            }
            
            Button(action:{
                showRegister = false
            }){
                Text("Have account? Sign in")
                    .foregroundColor(.black)
            }
            Spacer()
        }
    }
}

#Preview {
    RegisterPreviewWrapper()
}

struct RegisterPreviewWrapper: View {
    @State private var showRegister = true
    var body: some View {
        RegisterView(showRegister: $showRegister)
            .environmentObject(AuthViewModel())
    }
}

