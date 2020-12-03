//
//  ContentView.swift
//  TestAlamofire
//
//  Created by mason on 2020/11/23.
//

import SwiftUI
//Model
struct Post: Identifiable,Codable {
    let id = UUID()
    var title: String
    var body: String
    var userId: Int
}
//ViewModel
class ViewModel: ObservableObject {
    
    @Published var messages = " Messages inside observable object"
    
    @Published var postes: [Post] = []
    
    init() {
        self.getPost()
        self.fetchPost()
    }
    
    func getPost() {
        self.messages = "测试"
    }
    func fetchPost() {
        
        
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, res, error) in
            
            guard let data =  data else {return}
            
            DispatchQueue.main.async {
                self.postes = try! JSONDecoder().decode([Post].self, from: data)
            }
            
        }
        .resume()
    }
    
}

struct ContentView: View {
    
    @ObservedObject var postVM = ViewModel()
    
    var body: some View {
        
        List {
            ForEach(postVM.postes) { item in
                Text(item.title)
                
                
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
