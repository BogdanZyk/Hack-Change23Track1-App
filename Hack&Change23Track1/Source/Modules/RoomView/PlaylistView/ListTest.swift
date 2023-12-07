//
//  ListTest.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 07.12.2023.
//

import SwiftUI

struct ListTest: View {
    @State var lists = [Item(id: 1, title: "test"), Item(id: 2, title: "test2"), Item(id: 3, title: "test3")]
    var body: some View {
        NavigationStack {
            List {
                ForEach(lists) { item in
                    Text(item.title)
                }
                .onMove { indexSet, offset in
                    lists.move(fromOffsets: indexSet, toOffset: offset)
                }
            }
            .toolbar {
                            EditButton()
                        }
        }
    }
}

struct ListTest_Previews: PreviewProvider {
    static var previews: some View {
        ListTest()
    }
}


struct Item: Identifiable {
    var id: Int
    var title: String
}

struct EditableList<Element: Identifiable, Content: View>: View {
    @Binding var data: [Element]
    var content: (Binding<Element>) -> Content

    init(_ data: Binding<[Element]>,
         content: @escaping (Binding<Element>) -> Content) {
        self._data = data
        self.content = content
    }

    var body: some View {
        List {
            ForEach($data, content: content)
                .onMove { indexSet, offset in
                    data.move(fromOffsets: indexSet, toOffset: offset)
                }
                .onDelete { indexSet in
                    data.remove(atOffsets: indexSet)
                }
        }
//        .toolbar { EditButton() }
    }
}
