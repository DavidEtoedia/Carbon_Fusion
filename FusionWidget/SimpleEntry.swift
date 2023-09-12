//
//  SimpleEntry.swift
//  FusionWidgetExtension
//
//  Created by Inyene Etoedia on 03/09/2023.
//

import WidgetKit

struct SimpleEntry: TimelineEntry {
    let date: Date
    let dataModel: [DataModel]
}


extension DataModel {
    static func placeHolder(id: UUID) -> DataModel {
        DataModel(id: id, carbonKg: 0.5, createdAt: "2023-08-29 11:09:08.687", name: "Energy")
//        DataModel(id: id, carbonKg: 1.5, createdAt: "2023-03-04 11:09:02.687", name: "Flight"),
//        DataModel(id: id, carbonKg: 2.5, createdAt: "2023-02-12 11:09:04.687", name: "Logistics"),
//        DataModel(id: id, carbonKg: 2.2, createdAt: "2023-09-10 11:09:04.687", name: "Logistics"),
//        DataModel(id: id, carbonKg: 1.2, createdAt: "2023-01-01 10:09:02.687", name: "Flight"),

    }
}
