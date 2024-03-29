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
    static let YOUTUBE_API_KEY = "AIzaSyD1XYQgW1XnfDUFBpYaXZ4R_dlNo-2QLXc"
    static let youtube_BaseUrl = "https://youtube.googleapis.com/youtube/v3/search?"
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
    
    func getDiscoverMovies(completion: @escaping (Result<[Title], Error>) -> ()) {
        guard let url = URL(string: "\(Constants.baseUrl)/3/discover/movie?api_key=\(Constants.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=true&include_video=false&page=1&with_watch_monetization_types=flatrate") else {return}
        
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
    
    func search(with query: String, completion: @escaping (Result<[Title], Error>) -> ()) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.baseUrl)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else {return}
        
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
    
//q=harry&key=[YOUR_API_KEY]
    
    func getMovie(with query: String, completion: @escaping (Result<VideoElement, Error>) -> ()) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.youtube_BaseUrl)q=\(query)&key=\(Constants.YOUTUBE_API_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            guard let data = data, error == nil else {return}
            
            do{
                let res = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                completion(.success(res.items[0]))
               
            }
            catch{
                completion(.failure(error))
               
            }
            
        }
        
        task.resume()
        
    }
    
    
}
