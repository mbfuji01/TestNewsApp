//
//  APICaller.swift
//  TestNewsApp
//
//  Created by demasek on 02.11.2022.
//

import Foundation
import UIKit

//    apikey = 98242b99dd0d4f9fa617a793096efc9e

final class APICaller {
    
    static let shared = APICaller()
    
    struct Constants {
        static let topHeadlinesURL = URL(string: "https://newsapi.org/v2/everything?q=Apple&from=2022-11-1&sortBy=popularity&language=ru&apiKey=98242b99dd0d4f9fa617a793096efc9e#")
    }
    private init() {}
    
    public func getStories(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = Constants.topHeadlinesURL else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    print("Articles: \(result.articles.count)")
                    completion(.success(result.articles))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}

//MARK: - Models

struct APIResponse: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let title: String
    let urlToImage: String?
    let publishedAt: String
    let content: String
    let description: String
}
