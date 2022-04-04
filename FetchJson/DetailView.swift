//
//  DetailView.swift
//  FetchJson
//
//  Created by Yeongwoo Kim on 2022/03/31.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.presentationMode) var presentation
    @ObservedObject var viewModel = ViewModel()

    var user: UserModel.User
    
    var body: some View {
        VStack {
            Section{
                Text("User Data")
                    .font(titleFont)
            }
            
            VStack{
                Divider()
                HStack{
                    Text("Name: ")
                    Spacer()
                    Text(user.name)
                }
                Divider()
                HStack{
                    Text("Nickname: ")
                    Spacer()
                    Text(user.nickname)
                }
                Divider()
                HStack{
                    Text("Email: ")
                    Spacer()
                    Text(user.email)
                }
                Divider()
                HStack{
                    Text("Password: ")
                    Spacer()
                    Text(user.password)
                }
                Divider()
            }
            .font(contentFont)
            .padding()
            
            Button(action: {
                viewModel.deleteData(id: user.id)
                viewModel.loadData()
                presentation.wrappedValue.dismiss()
            }) {
                Text("Remove User")
                    .font(contentFont)
                    .padding()
                    .background(mainColor)
                    .foregroundColor(.white)
            }
        }
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(user: UserModel.User(name: "name", nickname: "nickname", email: "email", password: "password"))
    }
}
