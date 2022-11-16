//
//  RepositoryDetailPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by 内山和輝 on 2022/11/16.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol RepositoryDetailPresenterInput {
    func viewDidLoad(repository: Repository)
}

// sourcery: AutoMockable
protocol RepositoryDetailPresenterOutput: AnyObject {
    func configureText(_ repository: Repository)
    func configureAvatarImage(_ avatarImageURLString: String)
}

final class RepositoryDetailPresenter {
    private weak var view: RepositoryDetailPresenterOutput?
    init(view: RepositoryDetailPresenterOutput) {
        self.view = view
    }
}

extension RepositoryDetailPresenter: RepositoryDetailPresenterInput {
    func viewDidLoad(repository: Repository) {
        view?.configureText(repository)
        guard let avatarImageURLString = repository.owner.avatarURL else { return }
        view?.configureAvatarImage(avatarImageURLString)
    }
}
