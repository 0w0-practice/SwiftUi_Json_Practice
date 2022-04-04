//
//  ViewModel.swift
//  FetchJson
//
//  Created by Yeongwoo Kim on 2022/03/31.
//

import Foundation

private var myIp = internetDomain

class ViewModel: ObservableObject{
    @Published var items = [UserModel.User]()
    
    func loadData(){
        guard let url = URL(string: "http://\(myIp)/loadUser.php") else {return}
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            do{
                let result = try JSONDecoder().decode([UserModel.User].self, from: data!)
                print("Successfully Load Data")
                
                DispatchQueue.main.async {
                    self.items = result
                }
            } catch {
                print("No data")
            }
        }.resume()
    }
    
//    func saveData(name: String, nickname: String, email: String, password: String){
//        let urlString = "http://\(myIp)/storeUser.php?name=\(name)&nickname=\(nickname)&email=\(email)&password=\(password)"
//        print(urlString)
//
//        guard let url = URL(string: urlString) else {return}
//
//        URLSession.shared.dataTask(with: url).resume()
//    }
    
    func saveData(name: String, nickname: String, email: String, password: String){
//        guard let uploadData = try? JSONEncoder().encode(user) else { return }

        let urlString = "http://\(myIp)/storeUser.php"
        guard let url = URL(string: urlString) else {
            print("url error")
            return
        }

        let postData: [String: String] = ["name": name, "nickname": nickname, "email": email, "password": password]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONSerialization.data(withJSONObject: postData, options: [])
        
        if let json = String(data: request.httpBody!, encoding: .utf8){
            print("JSON is: ", json)
        }

        URLSession.shared.dataTask(with: request){ (data, response, error) in
            if error != nil{
                print("error")
                return
            }
        }.resume()
    }

//    func deleteData(id: String){
//        let urlString = "http://\(myIp)/deleteUser.php?id=\(id)"
//        print(urlString)
//
//        guard let url = URL(string: urlString) else {return}
//
//        URLSession.shared.dataTask(with: url).resume()
//    }
    
    func deleteData(id: String){
        let urlString = "http://\(myIp)/deleteUser.php"

        guard let url = URL(string: urlString) else {
            print("url error")
            return
        }

        let postData: [String: String] = ["id": id]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: postData, options: [])

        URLSession.shared.dataTask(with: request){ (data, response, error) in
            if error != nil{
                print("error")
                return
            }

            if let response = response{
                print(response)
            }
        }.resume()
    }
}
