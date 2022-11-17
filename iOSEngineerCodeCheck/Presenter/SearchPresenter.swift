//
//  SearchPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by 内山和輝 on 2022/11/16.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol SearchPresenterInput {
    func searchButtonClicked(searchWord: String)
    func numberOfRowsInSection() -> Int
    func didSelectRowAt(at indexPath: IndexPath)
    func cellForRowAt(at indexPath: IndexPath)
}

// sourcery: AutoMockable
protocol SearchPresenterOutput: AnyObject {
    func reloadTableView()
    func presentRepositoryViewController(selectedIndex: Int, repositories: [Repository])
    func configureRepositoryCellText(fullName: String, language: String?)
    func showHud()
    func hideHud()
    func showNothingEnteredAlert()
    func showNetworkErrorAlert()
    func showSearchResultsNotFountAlert()
}

final class SearchPresenter {
    private weak var view: SearchPresenterOutput?
    var repositories: [Repository] = []
    var selectedIndex: Int = 0
    init(view: SearchPresenterOutput, repositories: [Repository]) {
        self.view = view
        self.repositories = repositories
    }
}

extension SearchPresenter: SearchPresenterInput {
    func searchButtonClicked(searchWord: String) {
        if searchWord.count != 0 {
            view?.showHud()
        } else {
            view?.showNothingEnteredAlert()
            return
        }
        APIClient.fetchRepository(searchWord: searchWord, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let gitHubResponse):
                self.repositories = gitHubResponse.items
                if self.repositories.count == 0 {
                    DispatchQueue.main.async {
                        self.view?.hideHud()
                        self.view?.showSearchResultsNotFountAlert()
                        self.view?.reloadTableView()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.view?.reloadTableView()
                        self.view?.hideHud()
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.view?.hideHud()
                    self.view?.showNetworkErrorAlert()
                    self.view?.reloadTableView()
                }
                print(error)
            }
        })
    }

    func didSelectRowAt(at indexPath: IndexPath) {
        selectedIndex = indexPath.row
        view?.presentRepositoryViewController(selectedIndex: selectedIndex, repositories: repositories)
    }

    func numberOfRowsInSection() -> Int {
        return repositories.count
    }

    func cellForRowAt(at indexPath: IndexPath) {
        let repository = repositories[indexPath.row]
        view?.configureRepositoryCellText(fullName: repository.fullName, language: repository.language)
    }
}
