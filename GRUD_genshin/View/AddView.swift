//
//  AddView.swift
//  GRUD_genshin
//
//  Created by Максим Нуждин on 02.02.2022.
//

import CoreData
import SwiftUI

struct AddView: View {
    
    @StateObject var model = ViewModel()
    @Environment(\.managedObjectContext) var viewContext
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $model.name)
                Picker("Element own", selection: $model.element) {
                    ForEach(GenshinCharacterAdditions.Element.allCases, id: \.self) { e in
                        Text(e.rawValue)
                    }
                }
            } header: {
                Text("Character data")
            }
            
            Section {
                Picker("Belongs to region", selection: $model.region) {
                    ForEach(GenshinCharacterAdditions.Region.allCases, id: \.self) { r in
                        Text(r.rawValue)
                    }
                }
            } header: {
                Text("From")
            }
            
            Section {
                Picker("Released version", selection: $model.releasedVersion) {
                    ForEach(GenshinCharacterAdditions.gameVersions, id: \.self) { v in
                        Text(v.preciseTo(1))
                    }
                }
            } header: {
                Text("Released in")
            }
            
            Button("create") {
                let char = GenshinCharacter(context: viewContext)
                char.name = model.name
                char.region = model.region.rawValue
                char.element = model.element.rawValue
                char.patch = model.releasedVersion
                char.isFavorite = false
                
                try? viewContext.save()
            }.disabled(model.isDisabled)
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
