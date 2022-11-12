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

    func getImage(){
        let repository = searchViewController.repositories[searchViewController.index]

        titleLabel.text = repository["full_name"] as? String

        if let owner = repository["owner"] as? [String: Any] {
            if let avatarImageURL = owner["avatar_url"] as? String {
                URLSession.shared.dataTask(with: URL(string: avatarImageURL)!) { (data, response, error) in
                    let avatarImage = UIImage(data: data!)!
                    DispatchQueue.main.async {
                        self.avatarImageView.image = avatarImage
                    }
                }.resume()
            }
        }
    }


}
