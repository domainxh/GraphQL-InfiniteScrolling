//
//  ContentView.swift
//  GraphQL-Query
//
//  Created by xiaoheng.pan on 12/23/20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.queries) { query in
                QueryRow(query: query).onAppear() {
                    if self.viewModel.queries.last == query {
                        viewModel.fetchQuery()
                        print("Reached last item, performing fetch")
                    }
                }
            }.navigationBarTitle("GraphQL")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct QueryRow: View {
    var query: QueryItem
    var body: some View {
        VStack {
            Text("Avatar URL: \(query.avatarUrl)").lineLimit(1)
            Text("Login Name: \(query.loginName)")
            Text("Repository Name: \(query.repoName)")
            Text("Starcounts: \(query.starCount)")
        }
    }
}
