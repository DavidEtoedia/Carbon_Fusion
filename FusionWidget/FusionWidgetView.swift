//
//  FusionWidgetView.swift
//  FusionWidgetExtension
//
//  Created by Inyene Etoedia on 03/09/2023.
//

import WidgetKit
import SwiftUI


struct FusionWidgetEntryView : View {
    @Environment(\.widgetFamily) var widgetFamily
    var entry: Provider.Entry

    var body: some View {
        
        switch widgetFamily {
        case .systemMedium:
            WidgetMedium(entry: entry)
        default:
            Text("Was not implemented")
       
        }
    }
}

struct FusionWidgetEntryView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
//            FusionWidgetEntryView(entry: SimpleEntry(date: Date(), dataModel: [.placeHolder(id: UUID())]))
//                .previewContext(WidgetPreviewContext(family: .systemSmall))
            
            FusionWidgetEntryView(entry: SimpleEntry(date: Date(), dataModel: [.placeHolder(id: UUID()), .placeHolder(id: UUID())]))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
//
//            FusionWidgetEntryView(entry: SimpleEntry(date: Date(), dataModel: [.placeHolder(id: UUID())]))
//                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}
