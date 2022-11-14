//
//  UIImageView+URL.swift
//  iOSEngineerCodeCheck
//
//  Created by 内山和輝 on 2022/11/15.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit
import Nuke

extension UIImageView {
    func loadImage(with urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        loadImage(with: url)
    }

    func loadImage(with url: URL) {
        Nuke.loadImage(with: url, into: self)
    }
}
