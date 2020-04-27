//
//  JiraClient.swift
//  JiraSwift
//
//  Created by Christoph Pageler on 17.11.17.
//


import Foundation
import APIClient
import NIO
import NIOHTTP1


public class JiraClient: APIClient {

    static var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return df
    }

    public var myself: MyselfRoutes!
    public var project: ProjectRoutes!
    public var serverInfo: ServerInfoRoutes!
    public var search: SearchRoutes!
    public var issues: IssueRoutes!

    private var authorizationValue: String

    public init(baseURL: URL, token: String) {
        authorizationValue = "Bearer \(token)"

        super.init(baseURL: baseURL)
        initialize()
    }

    public init(baseURL: URL, username: String, password: String) {
        let base64Auth = "\(username):\(password)".data(using: .utf8)?.base64EncodedString() ?? ""
        authorizationValue = "Basic \(base64Auth)"

        super.init(baseURL: baseURL)

        initialize()
    }
    
    public init(baseURL: URL, username: String, token: String) {
        let base64Auth = "\(username):\(token)".data(using: .utf8)?.base64EncodedString() ?? ""
        authorizationValue = "Basic \(base64Auth)"

        super.init(baseURL: baseURL)

        initialize()
    }

    private func initialize() {
        (handler as? DefaultAPIRouteHandler)?.encoder.dateEncodingStrategy = .formatted(JiraClient.dateFormatter)
        (handler as? DefaultAPIRouteHandler)?.decoder.dateDecodingStrategy = .formatted(JiraClient.dateFormatter)

        myself = router(MyselfRoutes.self)
        project = router(ProjectRoutes.self)
        serverInfo = router(ServerInfoRoutes.self)
        search = router(SearchRoutes.self)
        issues = router(IssueRoutes.self)
    }

    private func router<T: JiraRoutes>(_ type: T.Type) -> T {
        return T(handler: handler, authorizationValue: authorizationValue)
    }

}
