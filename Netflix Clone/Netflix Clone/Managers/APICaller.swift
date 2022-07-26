//
//  APICaller.swift
//  Netflix Clone
//
//  Created by Sahil Sahu on 26/07/22.
//

import Foundation


struct Constants {
    static let API_KEY = "1b657371b995d7053dc65dad6f4dc2f1"
    static let baseUrl = "https://api.themoviedb.org"
}

enum APIError{
    case failedToGetData
}

class APICaller {
    
    static let shared = APICaller()
    
    
    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> ()) {
        
        guard let url = URL(string: "\(Constants.baseUrl)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            guard let data = data, error == nil else {return}
            
            do{
                let res = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(res.results))
            }
            catch{
                completion(.failure(error))
            }
            
        }
        
        task.resume()
        
    }
    
    func getTrendingTvs(completion: @escaping (Result<[Title], Error>) -> ()) {
        guard let url = URL(string: "\(Constants.baseUrl)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            guard let data = data, error == nil else {return}
            
            do{
                let res = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(res.results))
               
            }
            catch{
                completion(.failure(error))
            }
            
        }
        
        task.resume()
    }
    
    func getUpcomingMovies(completion: @escaping (Result<[Title], Error>) -> ()) {
        guard let url = URL(string: "\(Constants.baseUrl)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            guard let data = data, error == nil else {return}
            
            do{
                let res = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(res.results))
               
            }
            catch{
                completion(.failure(error))
            }
            
        }
        
        task.resume()
    }
    
    func getPopularMovies(completion: @escaping (Result<[Title], Error>) -> ()) {
        guard let url = URL(string: "\(Constants.baseUrl)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            guard let data = data, error == nil else {return}
            
            do{
                let res = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(res.results))
               
            }
            catch{
                completion(.failure(error))
            }
            
        }
        
        task.resume()
    }
    
    func getTopRatedMovies(completion: @escaping (Result<[Title], Error>) -> ()) {
        guard let url = URL(string: "\(Constants.baseUrl)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            guard let data = data, error == nil else {return}
            
            do{
                let res = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(res.results))
               
            }
            catch{
                completion(.failure(error))
            }
            
        }
        
        task.resume()
    }
    
    
}
