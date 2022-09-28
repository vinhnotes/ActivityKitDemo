//
//  MatchAttributes.swift
//  ActivityKit-Demo
//
//  Created by vinhvd on 27/09/2022.
//

import Foundation
import ActivityKit

struct MatchAttributes: ActivityAttributes {
    public typealias MatchStatus = ContentState

    public struct ContentState: Codable, Hashable {
        var matchHometeamFtScore: String
        var matchAwayteamFtScore: String
    }

    var matchHometeamName: String
    var matchAwayteamName: String
    var teamHomeBadge: String
    var teamAwayBadge: String
    var matchDate: String
}
