//
//  RepositoryDetailViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit
import Nuke

final class RepositoryDetailViewController: UIViewController {
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!
    @IBOutlet private weak var stargazersCountLabel: UILabel!
    @IBOutlet private weak var watchersCountLabel: UILabel!
    @IBOutlet private weak var forksCountLabel: UILabel!
    @IBOutlet private weak var openIssuesCountLabel: UILabel!

    var selectedIndex: Int?
    var repositories: [Repository]?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let selectedIndex = selectedIndex else { return }
        guard let repositories = repositories else { return }

        let repository = repositories[selectedIndex]

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
