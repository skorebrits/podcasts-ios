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
            Text(viewData.errorLabel)
            Button(viewData.errorRetryButton) {
                onRegry()
            }
        }
    }
}

#Preview {
    ErrorView(
        viewData: ErrorViewData(
            errorLabel: "Error",
            errorRetryButton: "Retry"
        ),
        onRegry: {
        debugPrint("pressed")
    })
}
