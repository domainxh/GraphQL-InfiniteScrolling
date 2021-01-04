//
//  NetworkManager.swift
//  GraphQL-Query
//
//  Created by xiaoheng.pan on 12/31/20.
//

import Foundation
import Apollo

class NetworkManager {
    
    private init() {}
    
    private let token = "placeholder-token" // https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/creating-a-personal-access-token
    private let url = URL(string: "https://api.github.com/graphql")!
    static let shared = NetworkManager()
    
    lazy var apollo: ApolloClient = {
        let store = ApolloStore()
        let network = RequestChainNetworkTransport(
            interceptorProvider: LegacyInterceptorProvider(store: store),
            endpointURL: url,
            additionalHeaders: ["Authorization": "Bearer \(token)"]
        )
        return .init(networkTransport: network, store: store)
    }()
}
