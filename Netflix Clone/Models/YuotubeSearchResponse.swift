//
//  YuotubeSearchResponse.swift
//  Netflix Clone
//
//  Created by Sasha Maksyutenko on 30.07.2023.
//

import Foundation
struct YuotubeSearchResponse:Codable{
    let items: [VideoElement]
    }
struct VideoElement:Codable{
    let id: IdVideoElement
}
struct IdVideoElement:Codable{
    let kind: String
    let videoId: String
}
