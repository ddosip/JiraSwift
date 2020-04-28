import Foundation
import NIO
import NIOHTTP1
import APIClient


public struct IssueRoutes: JiraRoutes {

    var handler: APIRouteHandler
    var authorizationValue: String

    public func getWorklog(issue id: String) -> EventLoopFuture<PageOfWorklogs> {
        handler.get("/rest/api/2/issue/\(id)/worklog", headers: defaultHeader())
    }

}
