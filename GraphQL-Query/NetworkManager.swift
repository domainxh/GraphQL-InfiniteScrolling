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
    private let token = "89f6696ca481744f8f9d6e641c96008dc88ac267"
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
