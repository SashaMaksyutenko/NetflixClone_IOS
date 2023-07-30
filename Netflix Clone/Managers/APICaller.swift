//
//  APICaller.swift
//  Netflix Clone
//
//  Created by Sasha Maksyutenko on 23.07.2023.
//

import Foundation
enum Sections:Int{
    case TrendingMovies=0
    case TrendingTv=1
    case Popular=2
    case Upcoming=3
    case TopRated=4
    
}
struct Constants{
    static let API_KEY="ff964588187f7c592b4b2989940575c6"
    static let baseUrl="https://api.themoviedb.org"
    static let YouTubeAPI_KEY="AIzaSyDjiddpIyBZzqxwuwH5aaRxHLlpsL-m4CA"
    static let YoutubeBaseUrl="https://youtube.googleapis.com/youtube/v3/search?"
}
enum APIError:Error{
   case failedToGetData
}
class APICaller{
    static let shared = APICaller()
    func getTrendingMovies(completion:@escaping (Result<[Title],Error>)->Void){
        guard let url=URL(string: "\(Constants.baseUrl)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else{return}
        let task=URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data=data, error==nil else{
                return
            }
            do{
                let results = try JSONDecoder().decode(trendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }
            catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    func getTrendingTvs(completion:@escaping (Result<[Title],Error>)->Void){
        guard let url=URL(string: "\(Constants.baseUrl)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else{return}
        let task=URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data=data, error==nil else{
                return
            }
            do{
                let results = try JSONDecoder().decode(trendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }
            catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    func getUpcomingMovies(completion:@escaping (Result<[Title],Error>)->Void){
        guard let url=URL(string: "\(Constants.baseUrl)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        let task=URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data=data,error==nil else {return}
            do{
                let results=try JSONDecoder().decode(trendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }
            catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    func getPopular(completion:@escaping (Result<[Title],Error>)->Void){
        guard let url = URL(string: "\(Constants.baseUrl)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(trendingTitleResponse.self, from: data)
                completion(.success(results.results))
                //print(results)
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        
        task.resume()
    }
    func getTopRated(completion:@escaping (Result<[Title],Error>)->Void){
        guard let url = URL(string: "\(Constants.baseUrl)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results=try JSONDecoder().decode(trendingTitleResponse.self, from: data)
                completion(.success(results.results))
                //print(results)
                
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    func getDiscoverMovies(completion:@escaping (Result<[Title],Error>)->Void){
        guard let url = URL(string: "\(Constants.baseUrl)/3/discover/movie?api_key=\(Constants.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(trendingTitleResponse.self, from: data)
                completion(.success(results.results))
                
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    func search(with query:String,completion:@escaping (Result<[Title],Error>)->Void){
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.baseUrl)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else {
            return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(trendingTitleResponse.self, from: data)
                completion(.success(results.results))
                
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    func getMovie(with query:String,completion:@escaping (Result<VideoElement,Error>)->Void){
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url=URL(string: "\(Constants.YoutubeBaseUrl)q=\(query)&key=\(Constants.YouTubeAPI_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                completion(.success(results.items[0]))
            } catch {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}

