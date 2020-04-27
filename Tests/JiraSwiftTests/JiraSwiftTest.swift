//
//  JiraSwiftTest.swift
//  JiraSwiftTests
//
//  Created by Sandro Wehrhahn on 05.03.19.
//


import XCTest
import JiraSwift


class JiraSwiftTest: XCTestCase  {

    func jiraCredentialsFromEnvironment() -> (URL, String, String) {
        guard let urlString = ProcessInfo.processInfo.environment["JIRA_URL"],
            let jiraUsername = ProcessInfo.processInfo.environment["JIRA_USERNAME"],
            let jiraToken = ProcessInfo.processInfo.environment["JIRA_OAUTH_TOKEN"],
            let jiraURL = URL(string: urlString)
        else {
            fatalError()
        }

        return (jiraURL, jiraUsername, jiraToken)
    }

    func jiraFromEnvironment() -> JiraClient {
        let credentials = jiraCredentialsFromEnvironment()
        return JiraClient(baseURL: credentials.0, username: credentials.1, token: credentials.2)

    }

}
