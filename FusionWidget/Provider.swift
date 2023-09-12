//
//  Provider.swift
//  FusionWidgetExtension
//
//  Created by Inyene Etoedia on 03/09/2023.
//

import WidgetKit

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), dataModel: [.placeHolder(id: UUID()), .placeHolder(id: UUID())])
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        Task{
            do{
                let dataModels: [DataModel] =  try await SupaBaseService.shared.getRequest(table: "Carbon")
                print(dataModels.count)
                let entry = SimpleEntry(date: .now, dataModel: dataModels)
                completion(entry)
                
            }catch{
                let entry = SimpleEntry(date: .now, dataModel:  [.placeHolder(id: UUID()), .placeHolder(id: UUID())])
                completion(entry)
            }
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        Task{
            do{
               let dataModels: [DataModel]  =  try await SupaBaseService.shared.getRequest(table: "Carbon")
                print(dataModels.count)
                let entry = SimpleEntry(date: .now, dataModel: dataModels)
                
                let timeLine = Timeline(entries: [entry], policy: .after(.now.advanced(by: 60 * 60 * 30)))
                completion(timeLine)
            }catch{
                let entries = SimpleEntry(date: .now, dataModel:  [.placeHolder(id: UUID()), .placeHolder(id: UUID())])
                let timeLine = Timeline(entries: [entries], policy: .after(.now.advanced(by: 60 * 60 * 30)))
                completion(timeLine)
            }
        }
    }
}



