//
//  ActivityKit_Demo_WidgetExtension.swift
//  ActivityKit-Demo-WidgetExtension
//
//  Created by vinhvd on 27/09/2022.
//

import WidgetKit
import SwiftUI
import ActivityKit

@main
struct Widgets: WidgetBundle {
    var body: some Widget {
        MatchInfoActivityWidget()
    }
}

struct MatchInfoActivityWidget: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: MatchAttributes.self) { context in
            // for device not support Dynamic Island
            VStack(alignment: .center) {
                Image(systemName: "target")
                Text(context.attributes.matchDate)
                    .multilineTextAlignment(.center)
                    .monospacedDigit()
                    .font(.caption2)
            }
        } dynamicIsland: { context in
            // for device support Dynamic Island
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    HStack {
                        AsyncImage(url: URL(string: context.attributes.teamHomeBadge))
                        { image in
                            image.resizable().scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
                DynamicIslandExpandedRegion(.trailing) {
                    HStack {
                        AsyncImage(url: URL(string: context.attributes.teamAwayBadge))
                        { image in
                            image.resizable().scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
                DynamicIslandExpandedRegion(.center) {
                    Label("\(context.state.matchHometeamFtScore) - \(context.state.matchAwayteamFtScore)",
                          systemImage: "").font(.system(size: 18))
                }
                DynamicIslandExpandedRegion(.bottom) {
                    HStack(alignment: .center) {
                        Image(systemName: "arrow.down.right.square")
                        Text(context.attributes.matchDate)
                            .multilineTextAlignment(.center)
                            .monospacedDigit()
                            .font(.system(size: 16))
                    }
                }
            } compactLeading: {
                Label {
                    Text(context.attributes.matchDate)
                } icon: {
                    Image(systemName: "target")
                }
                .font(.caption2)
                .foregroundColor(.red)
            } compactTrailing: {
                Text("Match Day")
                    .frame(width: 100)
                    .font(.caption2)
            } minimal: {
                VStack(alignment: .center) {
                    Image(systemName: "target")
                    Text(context.attributes.matchDate)
                        .multilineTextAlignment(.center)
                        .monospacedDigit()
                        .font(.caption2)
                }
            }
            .keylineTint(.accentColor)
        }

    }
    
}

// If you wish to preview the widget:
struct DemoWidget: View {
    var body: some View {
        VStack {
            Text("Push Ads Demo").font(.caption).foregroundColor(.secondary)
            VStack {
                Text("Get $100 OFF").bold().font(.system(size: 50)).foregroundColor(.secondary)
                Text("when purchase 🍕 every $1,000 | ONLY TODAY").font(.caption).italic()
            }
        }
    }
}

struct ActivityKit_Demo_WidgetExtension_Previews: PreviewProvider {
    static var previews: some View {
        DemoWidget()
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
