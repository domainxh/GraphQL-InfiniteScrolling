//
//  ViewModel.swift
//  GraphQL-Query
//
//  Created by xiaoheng.pan on 1/1/21.
//

import SwiftUI

class ViewModel: ObservableObject {
    
    @Published var queries = [QueryItem]()
    
    init() {
        fetchQuery()
    }
    
    func fetchQuery() {
        NetworkManager.shared.apollo.fetch(query: GraphQlQuery()) { [self] result in
            switch result {
            case .success(let result):
                result.data?.search.edges?.forEach { edge in
                    guard let repository = edge?.node?.asRepository else { return }
                    let queryItem = QueryItem(repoName: repository.name, loginName: repository.owner.login, avatarUrl: repository.owner.avatarUrl, starCount: repository.stargazerCount)
                    queries.append(queryItem)
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}

struct QueryItem: Identifiable {
    let id = UUID()
    var repoName: String
    var loginName: String
    var avatarUrl: String
    var starCount: Int
}
