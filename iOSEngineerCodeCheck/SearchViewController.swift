//
//  SearchViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!

    var repositories: [[String: Any]] = []
    var task: URLSessionTask?
    var index: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.text = "GitHubのリポジトリを検索できるよー"
        searchBar.delegate = self
    }

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
        if searchWord.isEmpty { return }
        guard let url = URL(string: "https://api.github.com/search/repositories?q=\(searchWord)") else {
            print("エンコードに失敗しました")
            return
        }

        task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            guard let json = try? JSONSerialization.jsonObject(with: data) else { return }
            guard let object = json as? [String: Any] else { return }
            guard let items = object["items"] as? [[String: Any]] else { return }

            self.repositories = items

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        task?.resume()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail" {
            let repositoryDetailViewController = segue.destination as! RepositoryDetailViewController
            repositoryDetailViewController.searchViewController = self
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let repository = repositories[indexPath.row]
        cell.textLabel?.text = repository["full_name"] as? String ?? ""
        cell.detailTextLabel?.text = repository["language"] as? String ?? ""
        cell.tag = indexPath.row
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
    }


}
