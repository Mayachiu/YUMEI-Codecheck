//
//  APIClient.swift
//  iOSEngineerCodeCheck
//
//  Created by 内山和輝 on 2022/11/13.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

enum APIClient {
    static func fetchRepository(searchWord: String, completion: @escaping (Result<Repositories, APIError>)-> Void) {
        if !searchWord.isEmpty {
            let encodedSearchWord = searchWord.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
            guard let url = URL(string: "https://api.github.com/search/repositories?q=" + String(encodedSearchWord!)) else {
                completion(.failure(.textEncodingError))
                return
            }

            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    do {
                        let json = try JSONDecoder().decode(Repositories.self, from: data)
                        completion(.success(json))
                    } catch {
                        completion(.failure(.decodeError))
                    }
                }
            }
            task.resume()
        }
    }
}
