// Generated using Sourcery 1.9.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif


@testable import iOSEngineerCodeCheck














class RepositoryDetailPresenterOutputMock: RepositoryDetailPresenterOutput {

    //MARK: - configureText

    var configureTextCallsCount = 0
    var configureTextCalled: Bool {
        return configureTextCallsCount > 0
    }
    var configureTextReceivedRepository: Repository?
    var configureTextReceivedInvocations: [Repository] = []
    var configureTextClosure: ((Repository) -> Void)?

    func configureText(_ repository: Repository) {
        configureTextCallsCount += 1
        configureTextReceivedRepository = repository
        configureTextReceivedInvocations.append(repository)
        configureTextClosure?(repository)
    }

    //MARK: - configureAvatarImage

    var configureAvatarImageCallsCount = 0
    var configureAvatarImageCalled: Bool {
        return configureAvatarImageCallsCount > 0
    }
    var configureAvatarImageReceivedAvatarImageURLString: String?
    var configureAvatarImageReceivedInvocations: [String] = []
    var configureAvatarImageClosure: ((String) -> Void)?

    func configureAvatarImage(_ avatarImageURLString: String) {
        configureAvatarImageCallsCount += 1
        configureAvatarImageReceivedAvatarImageURLString = avatarImageURLString
        configureAvatarImageReceivedInvocations.append(avatarImageURLString)
        configureAvatarImageClosure?(avatarImageURLString)
    }

}
class SearchPresenterOutputMock: SearchPresenterOutput {

    //MARK: - reloadTableView

    var reloadTableViewCallsCount = 0
    var reloadTableViewCalled: Bool {
        return reloadTableViewCallsCount > 0
    }
    var reloadTableViewClosure: (() -> Void)?

    func reloadTableView() {
        reloadTableViewCallsCount += 1
        reloadTableViewClosure?()
    }

    //MARK: - presentRepositoryViewController

    var presentRepositoryViewControllerSelectedIndexRepositoriesCallsCount = 0
    var presentRepositoryViewControllerSelectedIndexRepositoriesCalled: Bool {
        return presentRepositoryViewControllerSelectedIndexRepositoriesCallsCount > 0
    }
    var presentRepositoryViewControllerSelectedIndexRepositoriesReceivedArguments: (selectedIndex: Int, repositories: [Repository])?
    var presentRepositoryViewControllerSelectedIndexRepositoriesReceivedInvocations: [(selectedIndex: Int, repositories: [Repository])] = []
    var presentRepositoryViewControllerSelectedIndexRepositoriesClosure: ((Int, [Repository]) -> Void)?

    func presentRepositoryViewController(selectedIndex: Int, repositories: [Repository]) {
        presentRepositoryViewControllerSelectedIndexRepositoriesCallsCount += 1
        presentRepositoryViewControllerSelectedIndexRepositoriesReceivedArguments = (selectedIndex: selectedIndex, repositories: repositories)
        presentRepositoryViewControllerSelectedIndexRepositoriesReceivedInvocations.append((selectedIndex: selectedIndex, repositories: repositories))
        presentRepositoryViewControllerSelectedIndexRepositoriesClosure?(selectedIndex, repositories)
    }

    //MARK: - configureRepositoryCellText

    var configureRepositoryCellTextFullNameLanguageCallsCount = 0
    var configureRepositoryCellTextFullNameLanguageCalled: Bool {
        return configureRepositoryCellTextFullNameLanguageCallsCount > 0
    }
    var configureRepositoryCellTextFullNameLanguageReceivedArguments: (fullName: String, language: String?)?
    var configureRepositoryCellTextFullNameLanguageReceivedInvocations: [(fullName: String, language: String?)] = []
    var configureRepositoryCellTextFullNameLanguageClosure: ((String, String?) -> Void)?

    func configureRepositoryCellText(fullName: String, language: String?) {
        configureRepositoryCellTextFullNameLanguageCallsCount += 1
        configureRepositoryCellTextFullNameLanguageReceivedArguments = (fullName: fullName, language: language)
        configureRepositoryCellTextFullNameLanguageReceivedInvocations.append((fullName: fullName, language: language))
        configureRepositoryCellTextFullNameLanguageClosure?(fullName, language)
    }

}
