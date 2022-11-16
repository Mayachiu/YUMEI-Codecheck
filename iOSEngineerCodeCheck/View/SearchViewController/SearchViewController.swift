//
//  SearchViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!

    private var presenter: SearchPresenterInput!
    private var fullName: String = ""
    private var language: String? = ""

    private var task: URLSessionTask?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SearchPresenter.init(view: self)

        navigationItem.title = "Search View Controller"

        searchBar.text = "GitHubのリポジトリを検索できるよー"
        searchBar.delegate = self

        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UINib(nibName: "RepositoryCell", bundle: nil), forCellReuseIdentifier: "RepositoryCell")
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // 初期テキストの消去
        searchBar.text = ""
        return true
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        task?.cancel()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchWord = searchBar.text else { return }
        presenter.searchButtonClicked(searchWord: searchWord)
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRowAt(at: indexPath)
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRowsInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        presenter.cellForRowAt(at: indexPath)

        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell", for: indexPath) as! RepositoryCell
        cell.titleLabel.text = self.fullName
        cell.detailLabel.text = self.language ?? "-"
        cell.tag = indexPath.row
        return cell
    }
}

extension SearchViewController: SearchPresenterOutput {
    func reloadTableView() {
        tableView.reloadData()
    }

    func presentRepositoryViewController(selectedIndex: Int, repositories: [Repository]) {
        let repositoryDetailViewController = RepositoryDetailViewController()
        repositoryDetailViewController.selectedIndex = selectedIndex
        repositoryDetailViewController.repositories = repositories
        navigationController?.pushViewController(repositoryDetailViewController, animated: true)
    }

    func configureRepositoryCellText(fullName: String, language: String?) {
        self.fullName = fullName
        self.language = language
    }
}
