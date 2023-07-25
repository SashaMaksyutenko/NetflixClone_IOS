//
//  Tv.swift
//  Netflix Clone
//
//  Created by Sasha Maksyutenko on 25.07.2023.
//

import Foundation
struct trendingTvResponse:Codable{
    let results:[Tv]
    
}
struct Tv:Codable{
    let id:Int
    let media_type:String
    let original_name:String?
    let original_title:String?
    let poster_path:String?
    let overview:String?
    let vote_count:Int
    let release_date:String?
    let vote_average:Double
}
