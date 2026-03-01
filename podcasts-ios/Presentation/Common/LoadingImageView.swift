//
//  LoadingImageView.swift
//  podcasts-ios
//
//  Created by Sander Korebrits on 27/02/2026.
//

import SwiftUI

struct LoadingImageView: View {
    var url: String
    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .tint(.blue)
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            case .failure:
                Rectangle()
                    .fill(Color.gray)
            @unknown default:
                Rectangle()
                    .fill(Color.gray)
            }
        }
    }
}

#Preview {
    LoadingImageView(url: "https://is1-ssl.mzstatic.com/image/thumb/Podcasts221/v4/41/2b/4a/412b4acf-456d-0fe2-feac-8b77c51e0354/mza_2104858240694284743.jpg/100x100bb.png")
}
