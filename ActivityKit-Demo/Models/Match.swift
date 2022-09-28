//
//  Match.swift
//  ActivityKit-Demo
//
//  Created by vinhvd on 27/09/2022.
//

import Foundation

struct Match: Codable {
    let leagueName: String
    let matchDate: String
    let matchHometeamName, matchAwayteamName: String
    let matchHometeamFtScore, matchAwayteamFtScore: String
    let matchStadium: String
    let teamHomeBadge, teamAwayBadge: String

    enum CodingKeys: String, CodingKey {
        case leagueName = "league_name"
        case matchDate = "match_date"
        case matchHometeamName = "match_hometeam_name"
        case matchAwayteamName = "match_awayteam_name"
        case matchHometeamFtScore = "match_hometeam_ft_score"
        case matchAwayteamFtScore = "match_awayteam_ft_score"
        case matchStadium = "match_stadium"
        case teamHomeBadge = "team_home_badge"
        case teamAwayBadge = "team_away_badge"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        leagueName = try values.decode(String.self, forKey: .leagueName)
        matchDate = try values.decode(String.self, forKey: .matchDate)
        matchHometeamName = try values.decode(String.self, forKey: .matchHometeamName)
        matchAwayteamName = try values.decode(String.self, forKey: .matchAwayteamName)
        matchHometeamFtScore = try values.decode(String.self, forKey: .matchHometeamFtScore)
        matchAwayteamFtScore = try values.decode(String.self, forKey: .matchAwayteamFtScore)
        matchStadium = try values.decode(String.self, forKey: .matchStadium)
        teamHomeBadge = try values.decode(String.self, forKey: .teamHomeBadge)
        teamAwayBadge = try values.decode(String.self, forKey: .teamAwayBadge)
    }
    
    init(leagueName: String,
         matchDate: String,
         matchHometeamName: String,
         matchAwayteamName: String,
         matchHometeamFtScore: String,
         matchAwayteamFtScore: String,
         matchStadium: String,
         teamHomeBadge: String,
         teamAwayBadge: String) {
        self.leagueName = leagueName
        self.matchDate = matchDate
        self.matchHometeamName = matchHometeamName
        self.matchAwayteamName = matchAwayteamName
        self.matchHometeamFtScore = matchHometeamFtScore
        self.matchAwayteamFtScore = matchAwayteamFtScore
        self.matchStadium = matchStadium
        self.teamHomeBadge = teamHomeBadge
        self.teamAwayBadge = teamAwayBadge
    }
    
    static func example1() -> Match {
        return Match(leagueName: "Premier League", matchDate: "2022-10-02", matchHometeamName: "Arsenal", matchAwayteamName: "Liverpool", matchHometeamFtScore: "0", matchAwayteamFtScore: "0", matchStadium: "Mỹ Đình", teamHomeBadge: "", teamAwayBadge: "")
    }
    
    static func example2() -> Match {
        return Match(leagueName: "V League", matchDate: "2022-10-02", matchHometeamName: "Hà Nội", matchAwayteamName: "Nam Định", matchHometeamFtScore: "0", matchAwayteamFtScore: "0", matchStadium: "Mỹ Đình", teamHomeBadge: "", teamAwayBadge: "")
        
    }
}
