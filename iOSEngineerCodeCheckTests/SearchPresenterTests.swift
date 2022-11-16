//
//  SearchPresenterTests.swift
//  iOSEngineerCodeCheckTests
//
//  Created by 内山和輝 on 2022/11/17.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

@testable import iOSEngineerCodeCheck
import XCTest

final class SearchPresenterTests: XCTestCase {
    private var view: SearchPresenterOutputMock!

    var instance: SearchPresenter {
        SearchPresenter(view: view, repositories: repositoriesMock)
    }

    override func setUp() {
        view = SearchPresenterOutputMock()
    }

    func testReloadTableView() {
        let exp = expectation(description: "reloadTableView")
        DispatchQueue.main.async {
            self.view.reloadTableView()
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
        XCTAssertEqual(view.reloadTableViewCallsCount, 1)
    }

    func testDidSelectRowAt_callsCount() {
        instance.didSelectRowAt(at: [0, 2])
        XCTAssertEqual(view.presentRepositoryViewControllerSelectedIndexRepositoriesCallsCount, 1)
        XCTAssertEqual(view.presentRepositoryViewControllerSelectedIndexRepositoriesReceivedArguments?.selectedIndex, 2)
    }

    func testDidSelectRowAt_selectedIndex() {
        instance.didSelectRowAt(at: [0, 2])
        XCTAssertEqual(view.presentRepositoryViewControllerSelectedIndexRepositoriesReceivedArguments?.selectedIndex, 2)
    }

    func testDidSelectRowAt_repositories() {
        instance.didSelectRowAt(at: [0, 2])
        XCTAssertEqual(view.presentRepositoryViewControllerSelectedIndexRepositoriesReceivedArguments?.repositories, repositoriesMock)
    }

    func testNumberOfRowsInSection() {
        XCTAssertEqual(instance.numberOfRowsInSection(), repositoriesMock.count)
    }

    func testCellForRowAt_fullName() {
        instance.cellForRowAt(at: [0, 1])
        XCTAssertEqual(view.configureRepositoryCellTextFullNameLanguageReceivedArguments?.fullName, repositoriesMock[1].fullName)
    }

    func testCellForRowAt_language() {
        instance.cellForRowAt(at: [0, 1])
        XCTAssertEqual(view.configureRepositoryCellTextFullNameLanguageReceivedArguments?.language, repositoriesMock[1].language)
    }

    //Mockデータ
    private let repositoriesMock: [Repository] = [Repository(language: Optional("Jupyter Notebook"), stargazersCount: 13604, watchersCount: 13604, forksCount: 14969, openIssuesCount: 230, fullName: "selfteaching/the-craft-of-selfteaching", owner: iOSEngineerCodeCheck.Owner(avatarURL: Optional("https://avatars.githubusercontent.com/u/48558747?v=4"))), Repository(language: Optional("Lua"), stargazersCount: 123, watchersCount: 123, forksCount: 27, openIssuesCount: 4, fullName: "osyrisrblx/t", owner: iOSEngineerCodeCheck.Owner(avatarURL: Optional("https://avatars.githubusercontent.com/u/9200592?v=4")))]
}

extension Repository: Equatable {
    public static func == (lhs: iOSEngineerCodeCheck.Repository, rhs: iOSEngineerCodeCheck.Repository) -> Bool {
        return lhs.language == rhs.language &&
               lhs.stargazersCount == rhs.stargazersCount &&
               lhs.watchersCount == rhs.watchersCount &&
               lhs.forksCount == rhs.forksCount &&
               lhs.openIssuesCount == rhs.openIssuesCount &&
               lhs.fullName == rhs.fullName &&
               lhs .owner == rhs.owner
    }
}

extension Owner: Equatable {
    public static func == (lhs: Owner, rhs: Owner) -> Bool {
        return lhs.avatarURL == rhs.avatarURL
    }
}
