//
//  ErrorView.swift
//  ActivityKit-Demo
//
//  Created by vinhvd on 27/09/2022.
//

import SwiftUI

struct ErrorView: View {
    @ObservedObject var repository: LiveScoreRepository
    
    var body: some View {
        VStack {
            Text("😿")
                .font(.system(size: 80))
            Text(repository.errorMessage ?? "")
            Button {
                repository.fetchAllLiveScore()
            } label: {
                Text("Try again")
            }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(repository: LiveScoreRepository())
    }
}
