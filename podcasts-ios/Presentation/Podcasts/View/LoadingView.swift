//
//  LoadingView.swift
//  podcasts-ios
//
//  Created by Sander Korebrits on 26/02/2026.
//

import SwiftUI

struct LoadingView: View {
    var viewData: LoadingViewData

    var body: some View {
        ProgressView(viewData.label)
            .tint(.blue)
            .progressViewStyle(.circular)
    }
}

#Preview {
    LoadingView(viewData: LoadingViewData(label: "loading"))
}
