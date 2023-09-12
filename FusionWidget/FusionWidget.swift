//
//  FusionWidget.swift
//  FusionWidget
//
//  Created by Inyene Etoedia on 03/09/2023.
//

import WidgetKit
import SwiftUI

struct FusionWidget: Widget {
    let kind: String = "FusionWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            FusionWidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemMedium])
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct FusionWidget_Previews: PreviewProvider {
    static var previews: some View {
        FusionWidgetEntryView(entry: SimpleEntry(date: Date(), dataModel: [.placeHolder(id: UUID())]))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
