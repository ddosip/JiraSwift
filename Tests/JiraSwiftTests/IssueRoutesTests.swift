//
//  File.swift
//  
//
//  Created by Dmitriy Osipov on 27.04.2020.
//

import XCTest
import JiraSwift


class IssueRoutesTests: JiraSwiftTest {

    func testGetIssueWorklog() throws {
        let jiraClient = jiraFromEnvironment()
        let worklog = try jiraClient.issues.getWorklog(issue: "ID-112").wait()
        XCTAssertFalse(worklog.worklogs.isEmpty)
    }

}
