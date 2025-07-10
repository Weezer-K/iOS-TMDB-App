//
//  SettingView.swift
//  iOS-TMDB-APP
//
//  Created by Kyle Peters on 5/28/25.
//


import SwiftUI

struct SettingView: View {
    @StateObject private var viewModel: SettingsViewModel
    @State private var showResetAlert = false

    init() {
        _viewModel = StateObject(wrappedValue: SettingsViewModel())
    }

    var body: some View {
        VStack {
            Button(action: {
                showResetAlert = true
            }) {
                VStack {
                    Text("Reset to\nFactory Settings")
                        .font(.title2)
                        .multilineTextAlignment(.center)
                }
                .foregroundColor(.white)
                .padding()
                .frame(width: 200, height: 200)
                .background(Color.red)
                .clipShape(Circle())
            }
            .alert("Reset to Factory Settings?", isPresented: $showResetAlert) {
                Button("Cancel", role: .cancel) {}
                Button("Reset", role: .destructive) {
                    viewModel.resetFavorites()
                }
            } message: {
                Text("This will remove all your favorites and restore default settings. This action cannot be undone.")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
