//
//  ContentView.swift
//  FetchJson
//
//  Created by Yeongwoo Kim on 2022/03/31.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()

    var body: some View {
        NavigationView{
            VStack {
                HStack{
                    Text("User List")
                        .font(titleFont)
                        .padding(.horizontal)
                    Spacer()
                    NavigationLink(destination: AddView()) {
                        Image(systemName: "plus")
                            .padding(.horizontal)
                    }
                }
                
                List{
                    ForEach(viewModel.items, id: \.id){ item in
                        NavigationLink(destination: DetailView(user: item)) {
                            Text(item.name)
                                .font(contentFont)
                        }
                    }
                }
            }
            .onAppear{
                viewModel.loadData()
            }
            .navigationTitle("Users")
            .navigationBarHidden(true)
            .navigationBarTitleDisplayMode(.inline)
        }
        .refreshable {
            viewModel.loadData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
