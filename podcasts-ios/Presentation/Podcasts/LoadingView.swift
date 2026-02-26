//
//  LoadingView.swift
//  podcasts-ios
//
//  Created by Sander Korebrits on 26/02/2026.
//

import SwiftUI

struct LoadingView: View {

    var body: some View {
        //TODO: replace hardcoded label with viewData
        ProgressView("Loading...")
            .tint(.blue)
            .progressViewStyle(.circular)
    }
}

#Preview {
    LoadingView()
}
