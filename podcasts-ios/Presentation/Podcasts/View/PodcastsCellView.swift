//
//  PodcastsCellView.swift
//  podcasts-ios
//
//  Created by Sander Korebrits on 27/02/2026.
//

import SwiftUI

struct PodcastsCellView: View {
    var viewData: PodcastsCellViewData

    var body: some View {
        HStack {
            LoadingImageView(url: viewData.imageURL)
                .frame(width: 80, height: 80)

            VStack(alignment: .leading, spacing: 6) {
                Text(viewData.label)
                    .bold()

                Text(viewData.secondaryLabel)
                    .font(.caption)
            }
        }
    }
}

#Preview {
    List {
        PodcastsCellView(viewData:
                            PodcastsCellViewData(
                                id: "/unique",
                                label: "test",
                                secondaryLabel: "Artist",
                                imageURL:"https://is1-ssl.mzstatic.com/image/thumb/Podcasts221/v4/41/2b/4a/412b4acf-456d-0fe2-feac-8b77c51e0354/mza_2104858240694284743.jpg/100x100bb.png"
                            )
        )
    }
}
