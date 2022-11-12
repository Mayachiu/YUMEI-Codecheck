//
//  RepositoryDetailViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class RepositoryDetailViewController: UIViewController {
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!
    @IBOutlet private weak var stargazersCountLabel: UILabel!
    @IBOutlet private weak var watchersCountLabel: UILabel!
    @IBOutlet private weak var forksCountLabel: UILabel!
    @IBOutlet private weak var openIssuesCountLabel: UILabel!

    var searchViewController: SearchViewController?
    private var repository: [String: Any] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let searchViewController = searchViewController else { return }
        guard let selectedIndex = searchViewController.selectedIndex else { return }

        repository = searchViewController.repositories[selectedIndex]

        languageLabel.text = "Written in \(repository["language"] as? String ?? "")"
        stargazersCountLabel.text = "\(repository["stargazers_count"] as? Int ?? 0) stars"
        watchersCountLabel.text = "\(repository["watchers_count"] as? Int ?? 0) watchers"
        forksCountLabel.text = "\(repository["forks_count"] as? Int ?? 0) forks"
        openIssuesCountLabel.text = "\(repository["open_issues_count"] as? Int ?? 0) open issues"
        getImage()
    }

    private func getImage() {
        titleLabel.text = repository["full_name"] as? String

        guard let owner = repository["owner"] as? [String: Any] else { return }
        guard let avatarImageURLString = owner["avatar_url"] as? String else { return }
        guard let avatarImageURL = URL(string: avatarImageURLString) else { return }

        URLSession.shared.dataTask(with: avatarImageURL) { (data, response, error) in
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            
            let avatarImage = image

            DispatchQueue.main.async {
                self.avatarImageView.image = avatarImage
            }
        }.resume()
    }


}
