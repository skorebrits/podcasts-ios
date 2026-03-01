//
//  ErrorView.swift
//  podcasts-ios
//
//  Created by Sander Korebrits on 26/02/2026.
//

import SwiftUI

struct ErrorView: View {

    var viewData: ErrorViewData
    var onRegry: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            Text(viewData.errorTItle)
            Button(viewData.errorRetryButton) {
                onRegry()
            }
        }
    }
}

#Preview {
    ErrorView(
        viewData: ErrorViewData(
            errorTItle: "Error",
            errorRetryButton: "Retry"
        ),
        onRegry: {
        debugPrint("pressed")
    })
}
