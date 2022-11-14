//
//  RepositoryDetailViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit
import Nuke

class RepositoryDetailViewController: UIViewController {
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!
    @IBOutlet private weak var stargazersCountLabel: UILabel!
    @IBOutlet private weak var watchersCountLabel: UILabel!
    @IBOutlet private weak var forksCountLabel: UILabel!
    @IBOutlet private weak var openIssuesCountLabel: UILabel!

    var searchViewController: SearchViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let searchViewController = searchViewController else { return }
        guard let selectedIndex = searchViewController.selectedIndex else { return }

        let repository = searchViewController.repositories[selectedIndex]

        titleLabel.text = repository.fullName
        languageLabel.text = "Written in \(repository.language ?? "")"
        stargazersCountLabel.text = "\(repository.stargazersCount) stars"
        watchersCountLabel.text = "\(repository.watchersCount) watchers"
        forksCountLabel.text = "\(repository.forksCount) forks"
        openIssuesCountLabel.text = "\(repository.openIssuesCount) open issues"

        configureAvatarImage(repository)
    }

    private func configureAvatarImage(_ repository: Repository) {
        guard let avatarImageURLString = repository.owner.avatarURL else { return }
        Nuke.loadImage(with: avatarImageURLString, into: self.avatarImageView)
    }


}
