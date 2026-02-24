//
//  LinksApiModel.swift
//  podcasts-ios
//
//  Created by Sander Korebrits on 24/02/2026.
//

struct LinkApiModel: Decodable {
    let url: String

    enum CodingKeys: String, CodingKey {
        case url = "self"
    }
}
