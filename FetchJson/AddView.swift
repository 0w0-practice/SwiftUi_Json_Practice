//
//  AddView.swift
//  FetchJson
//
//  Created by Yeongwoo Kim on 2022/03/31.
//

import SwiftUI

struct AddView: View {
    @State private var name: String = ""
    @State private var nickname: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @ObservedObject var viewModel = ViewModel()
    @Environment(\.presentationMode) var presentation
    
    private let userModel = UserModel()
    @State private var validEmail = true
    @State private var validPassword = true
    
    var body: some View {
        VStack{
            Section{
                Text("Create User")
                    .font(titleFont)
            }
            
            Section{
                Divider()
                
                VStack {
                    HStack {
                        Image(systemName: "person.circle")
                        TextField("Name", text: $name)
                            .padding()
                    }
                    Text(" ")
                        .font(.caption)
                }
                
                Divider()
                
                VStack {
                    HStack {
                        Image(systemName: "person")
                        TextField("Nickname", text: $nickname)
                            .padding()
                    }
                    Text(" ")
                        .font(.caption)
                }
                
                Divider()
                
                VStack{
                    HStack {
                        Image(systemName: "envelope")
                        TextField("Email", text: $email)
                            .padding()
                    }
                    Text("Wrong Email Format")
                        .font(.caption)
                        .foregroundColor(.red)
                        .opacity(validEmail ? 0 : 1)
                }
                
                Divider()
                
                VStack{
                    HStack {
                        Image(systemName: "key")
                        SecureField("Password", text: $password)
                            .padding()
                    }
                    Text("Wrong Password Format")
                        .font(.caption)
                        .foregroundColor(.red)
                        .opacity(validPassword ? 0 : 1)
                }
                
                Divider()
            }
            
            Section{
                Button(action: {
                    if userModel.isValidEmail(email: email) && userModel.isValidPassword(password: password){
                        viewModel.saveData(name: name, nickname: nickname, email: email, password: password)
                        viewModel.loadData()
                        presentation.wrappedValue.dismiss()
                    }else{
                        if !userModel.isValidEmail(email: email){
                            validEmail=false
                        }
                        if !userModel.isValidPassword(password: password){
                            validPassword=false
                        }
                        
                    }
                }) {
                    Text("Add User")
                        .font(contentFont)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                }
            }
        }
        .padding()
    }
}

struct AddView_Previews: PreviewProvider {
    let userModel: UserModel
    static var previews: some View {
        AddView()
    }
}
