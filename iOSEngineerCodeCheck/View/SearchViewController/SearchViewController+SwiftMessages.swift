//
//  SearchViewController+SwiftMessages.swift
//  iOSEngineerCodeCheck
//
//  Created by 内山和輝 on 2022/11/17.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit
import SwiftMessages

extension SearchViewController {
    func configureNothingEnteredAlert() {
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(.warning)
        view.configureContent(title: "何も入力されていません", body: "")
        view.button?.isHidden = true
        view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        (view.backgroundView as? CornerRoundingView)?.cornerRadius = 10
        var config = SwiftMessages.Config()
        config.presentationStyle = .center
        SwiftMessages.show(config: config, view: view)
    }

    func configureNetworkErrorAlert() {
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(.error)
        view.configureContent(title: "ネットワークエラーです", body: "")
        view.button?.isHidden = true
        view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        (view.backgroundView as? CornerRoundingView)?.cornerRadius = 10
        var config = SwiftMessages.Config()
        config.presentationStyle = .center
        SwiftMessages.show(config: config, view: view)
    }

    func configureSearchResultsNotFountAlert() {
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(.warning)
        view.configureContent(title: "検索結果がみつかりませんでした", body: "")
        view.button?.isHidden = true
        view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        (view.backgroundView as? CornerRoundingView)?.cornerRadius = 10
        var config = SwiftMessages.Config()
        config.presentationStyle = .center
        SwiftMessages.show(config: config, view: view)
    }
}
