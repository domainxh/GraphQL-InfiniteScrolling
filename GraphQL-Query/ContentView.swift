//
//  ContentView.swift
//  GraphQL-Query
//
//  Created by xiaoheng.pan on 12/23/20.
//

import SwiftUI

struct ContentView: View {
    
    @State var name = ""
    
    var body: some View {
        Text(name).onAppear(perform: {
            NetworkManager.shared.apollo.fetch(query: GraphQlQuery()) { result in
                switch result {
                case .success(let graphQLResult):
                    DispatchQueue.main.async {
                        print("Result: \(graphQLResult)")
                    }
                case .failure(let error):
                    print("Error: \(error)")
                }

            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
