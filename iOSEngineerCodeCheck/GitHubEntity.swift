//
//  GitHubEntity.swift
//  iOSEngineerCodeCheck
//
//  Created by 内山和輝 on 2022/11/13.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

struct Repositories: Codable {
    let items: [Repository]
}

struct Repository: Codable {
    let language: String?
    let stargazersCount: Int
    let watchersCount: Int
    let forksCount: Int
    let openIssuesCount: Int
    let fullName: String
    let owner: Owner

    enum CodingKeys: String, CodingKey {
        case language
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case forksCount = "forks_count"
        case openIssuesCount = "open_issues_count"
        case fullName = "full_name"
        case owner
    }

}

struct Owner: Codable {
    let avatarURL: String?

    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
    }
}
