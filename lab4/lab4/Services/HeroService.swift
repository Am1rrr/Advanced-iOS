//
//  HeroService.swift
//  lab4
//
//  Created by amir on 26.03.2025.
//

import Foundation

class HeroService {
    static let shared = HeroService()
    private let baseURL = "https://akabab.github.io/superhero-api/api"
    
//    func fetchHeroes(completion: @escaping (Result<[Hero], Error>) -> Void) {
//        guard let url = URL(string: "\(baseURL)/all.json") else { return }
//        URLSession.shared.dataTask(with: url) { data, _, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//            guard let data = data else { return }
//            do {
//                let heroes = try JSONDecoder().decode([Hero].self, from: data)
//                DispatchQueue.main.async {
//                    completion(.success(heroes))
//                }
//            } catch {
//                completion(.failure(error))
//            }
//        }.resume()
//    }
    func fetchHeroes(completion: @escaping (Result<[Hero], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/all.json") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }

            // Debug: Print raw JSON response
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON: \(jsonString)")
            }

            do {
                let heroes = try JSONDecoder().decode([Hero].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(heroes))
                }
            } catch {
                completion(.failure(error))
                print("Decoding Error: \(error.localizedDescription)")
            }
        }.resume()
    }

}

