//
//  ContentView.swift
//  GraphQL-Query
//
//  Created by xiaoheng.pan on 12/23/20.
//

import SwiftUI
import KingfisherSwiftUI

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
            }.navigationBarTitle("GraphQL Queries")
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
        VStack(alignment: .leading) {
            KFImage(URL(string: "\(query.avatarUrl)")!).resizable().frame(width: 40, height: 40)
            Text("Login Name: \(query.loginName)")
            Text("Repository Name: \(query.repoName)")
            Text("Starcounts: \(query.starCount)")
        }
    }
}
