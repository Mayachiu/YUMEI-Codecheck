//
//  RepositoryDetailViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class RepositoryDetailViewController: UIViewController {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var stargazersCountLabel: UILabel!
    @IBOutlet weak var watchersCountLabel: UILabel!
    @IBOutlet weak var forksCountLabel: UILabel!
    @IBOutlet weak var openIssuesCountLabel: UILabel!

    var searchViewController: SearchViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        let repository = searchViewController.repositories[searchViewController.index]

        languageLabel.text = "Written in \(repository["language"] as? String ?? "")"
        stargazersCountLabel.text = "\(repository["stargazers_count"] as? Int ?? 0) stars"
        watchersCountLabel.text = "\(repository["watchers_count"] as? Int ?? 0) watchers"
        forksCountLabel.text = "\(repository["forks_count"] as? Int ?? 0) forks"
        openIssuesCountLabel.text = "\(repository["open_issues_count"] as? Int ?? 0) open issues"
        getImage()
    }

    func getImage() {
        let repository = searchViewController.repositories[searchViewController.index]

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
