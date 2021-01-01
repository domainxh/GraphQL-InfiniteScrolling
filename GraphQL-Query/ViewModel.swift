//
//  ViewModel.swift
//  GraphQL-Query
//
//  Created by xiaoheng.pan on 1/1/21.
//

import SwiftUI

class ViewModel: ObservableObject {
    
    @Published var queries = [QueryItem]()
    private var pageInfo: GraphQlQuery.Data.Search.PageInfo?
    
    init() {
        fetchQuery()
    }
    
    func fetchQuery() {
        var query: GraphQlQuery
        if queries.isEmpty {
            query = GraphQlQuery(query: "graphql", first: 15)
        } else {
            query = GraphQlQuery(query: "graphql", first: 15, after: pageInfo?.endCursor)
        }
        NetworkManager.shared.apollo.fetch(query: query) { [self] result in
            switch result {
            case .success(let result):
                result.data?.search.edges?.forEach { edge in
                    guard let repository = edge?.node?.asRepository else { return }
                    let queryItem = QueryItem(repoName: repository.name, loginName: repository.owner.login, avatarUrl: repository.owner.avatarUrl, starCount: repository.stargazerCount)
                    queries.append(queryItem)
                }
                pageInfo = result.data?.search.pageInfo
                print("pageInfo: \(String(describing: pageInfo))")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}

struct QueryItem: Identifiable, Equatable {
    let id = UUID()
    var repoName: String
    var loginName: String
    var avatarUrl: String
    var starCount: Int
}
