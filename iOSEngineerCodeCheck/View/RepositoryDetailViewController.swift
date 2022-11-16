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

    private var presenter: RepositoryDetailPresenterInput!
    var selectedIndex: Int?
    var repositories: [Repository]?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = RepositoryDetailPresenter.init(view: self)

        guard let selectedIndex = selectedIndex else { return }
        guard let repositories = repositories else { return }

        presenter.viewDidLoad(repository: repositories[selectedIndex])
    }


}

extension RepositoryDetailViewController: RepositoryDetailPresenterOutput {
    func configureText(_ repository: Repository) {
        titleLabel.text = repository.fullName
        languageLabel.text = "Written in \(repository.language ?? "")"
        stargazersCountLabel.text = "\(repository.stargazersCount) stars"
        watchersCountLabel.text = "\(repository.watchersCount) watchers"
        forksCountLabel.text = "\(repository.forksCount) forks"
        openIssuesCountLabel.text = "\(repository.openIssuesCount) open issues"
    }

    func configureAvatarImage(_ avatarImageURLString: String) {
        Nuke.loadImage(with: avatarImageURLString, into: self.avatarImageView)
    }
}
