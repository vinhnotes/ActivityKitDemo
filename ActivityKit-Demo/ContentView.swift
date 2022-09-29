//
//  ContentView.swift
//  ActivityKit-Demo
//
//  Created by vinhvd on 27/09/2022.
//

import SwiftUI
import ActivityKit

struct ContentView: View {
    @StateObject var viewModel = LiveScoreViewModel()
    
    var body: some View {
        if viewModel.isLoading {
            LoadingView()
        } else if viewModel.errorMessage != nil {
            ErrorView(viewModel: viewModel)
        } else if !viewModel.matches.isEmpty {
            NavigationView {
                ZStack {
                    backgroundImage
                    action
                }
            }.onAppear {
                Task {
                    let match = viewModel.matches.first

                    print(match?.teamHomeBadge ?? "NIL")
                    let matchAttibutes = MatchAttributes(matchHometeamName: match?.matchHometeamName ?? "nil",
                                                         matchAwayteamName: match?.matchAwayteamName ?? "nil",
                                                         teamHomeBadge: match?.teamHomeBadge ?? "nil",
                                                         teamAwayBadge: match?.teamAwayBadge ?? "nil",
                                                         matchDate: match?.matchDate ?? "nil")
                    let initialContentState = MatchAttributes.MatchStatus(matchHometeamFtScore: match?.matchHometeamFtScore ?? "0", matchAwayteamFtScore: match?.matchAwayteamFtScore ?? "0")
                    
                    do {
                        if Activity<MatchAttributes>.activities.count > 0 {

                            let matchAttibutesStatus = MatchAttributes.MatchStatus(matchHometeamFtScore: "1", matchAwayteamFtScore: "1")
                            for activity in Activity<MatchAttributes>.activities {
                                await activity.update(using: matchAttibutesStatus)
                            }
                        } else {
                            let matchActivity = try Activity<MatchAttributes>.request(
                                attributes: matchAttibutes,
                                contentState: initialContentState,
                                pushType: nil)
                            print("Requested a Match Live Activity \(matchActivity.id)")
                        }
                    } catch (let error) {
                        print("Error requesting Match Live Activity \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    // MARK: - views
    var backgroundImage: some View {
        AsyncImage(url: URL(string: "https://images.pexels.com/photos/3074920/pexels-photo-3074920.jpeg"))
        { image in
            image.resizable().scaledToFill()
        } placeholder: {
            ProgressView()
        }.ignoresSafeArea(.all)
    }

    var action: some View {
        VStack {
            Spacer()
            
            HStack(spacing: 0) {
                Button(action: { update() }) {
                    HStack {
                        Spacer()
                        Text("Get Update Score").font(.headline)
                        Spacer()
                    }.frame(height: 60)
                }.tint(.blue)
            }
        }
    }
    
    // MARK: - functions
    
    func update() {
        print("Update score...")
        viewModel.fetchAllLiveScore()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
