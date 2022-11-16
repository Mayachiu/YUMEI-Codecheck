//
//  RepositoryDetailPresenterTests.swift
//  iOSEngineerCodeCheckTests
//
//  Created by 内山和輝 on 2022/11/17.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

@testable import iOSEngineerCodeCheck
import XCTest

final class RepositoryDetailPresenterTests: XCTestCase {
    private var view: RepositoryDetailPresenterOutputMock!

    private var instance: RepositoryDetailPresenter {
        RepositoryDetailPresenter(view: view)
    }

    override func setUp() {
        view = RepositoryDetailPresenterOutputMock()
    }

    func testCongigureText() {
        instance.viewDidLoad(repository: repositoryMock)
        XCTAssertEqual(view.configureTextReceivedRepository?.fullName, repositoryMock.fullName)
        XCTAssertEqual(view.configureTextReceivedRepository?.language, repositoryMock.language)
    }

    func testCtestConfigureAvatarImage() {
        instance.viewDidLoad(repository: repositoryMock)
        XCTAssertEqual(view.configureAvatarImageReceivedAvatarImageURLString, repositoryMock.owner.avatarURL)
    }

    //Mockデータ
    private let repositoryMock: Repository = Repository(language: Optional("R"), stargazersCount: 3471, watchersCount: 3471, forksCount: 766, openIssuesCount: 71, fullName: "twitter/AnomalyDetection", owner: iOSEngineerCodeCheck.Owner(avatarURL: Optional("https://avatars.githubusercontent.com/u/50278?v=4")))
}

