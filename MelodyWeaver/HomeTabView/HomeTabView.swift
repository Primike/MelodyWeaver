//
//  HomeTabView.swift
//  MelodyWeaver
//
//  Created by Prince Avecillas on 1/24/24.
//

import SwiftUI

struct HomeTabView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(0..<100) { item in
                    NavigationLink(destination: Color.blue) {
                        HStack {
                            Text("Item \(item)")
                                .font(.headline)
                            Spacer()
                            Text("Detail")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .onDelete(perform: delete)
                .onMove(perform: move)
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("My Songs")
            .navigationBarItems(leading: EditButton(), trailing: EditButton())
        }
    }
    
    func delete(indexSet: IndexSet) {
//        fruits.remove(atOffsets: indexSet)
    }
    
    func move(indices: IndexSet, newOffset: Int) {
//        fruits.move(fromOffsets: indices, toOffset: newOffset)
    }
}

#Preview {
    HomeTabView()
}
