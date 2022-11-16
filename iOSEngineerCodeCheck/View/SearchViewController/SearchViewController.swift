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

    var repositories: [Repository] = []
    private var task: URLSessionTask?
    var selectedIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Search View Controller"

        searchBar.text = "GitHubのリポジトリを検索できるよー"
        searchBar.delegate = self

        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UINib(nibName: "RepositoryCell", bundle: nil), forCellReuseIdentifier: "RepositoryCell")
    }

    private func prepareRepositoryDetailViewController () {
        let repositoryDetailViewController = RepositoryDetailViewController()
        repositoryDetailViewController.searchViewController = self
        navigationController?.pushViewController(repositoryDetailViewController, animated: true)
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
        APIClient.fetchRepository(searchWord: searchWord, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let gitHubResponse):
                self.repositories = gitHubResponse.items
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        })
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        prepareRepositoryDetailViewController()
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell", for: indexPath) as! RepositoryCell
        let repository = repositories[indexPath.row]
        cell.titleLabel.text = repository.fullName
        cell.detailLabel.text = repository.language ?? "-"
        cell.tag = indexPath.row
        return cell
    }
}
