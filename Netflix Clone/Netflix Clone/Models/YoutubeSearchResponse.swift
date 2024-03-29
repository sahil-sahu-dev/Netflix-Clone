//
//  YoutubeSearchResult.swift
//  Netflix Clone
//
//  Created by Sahil Sahu on 30/07/22.
//

import Foundation


struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
}


struct VideoElement: Codable {
    let id: IdVideoElement
}


struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
