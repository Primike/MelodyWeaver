//
//  HomeView.swift
//  MelodyWeaver
//
//  Created by Prince Avecillas on 1/24/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    @State var showNewScreen = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.songs) { item in
                    NavigationLink(destination: NewSongView(viewModel: SheetMusicViewModel())) {
                        HStack {
                            Text("\(item.name)")
                                .font(.headline)
                            Spacer()
                            Text("\(item.date)")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .onDelete(perform: delete)
                .onMove(perform: move)
                .swipeActions(edge: .trailing, allowsFullSwipe: false, content: { Button(action: {}, label: {
                    Text("Delete")
                })})
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("My Songs")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showNewScreen = true
                    } label: {
                        Label("New Song", systemImage: "plus")
                    }
                }
            }
            .navigationDestination(isPresented: $showNewScreen) {
                NewSongView(viewModel: SheetMusicViewModel())
            }
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
    HomeView(viewModel: HomeViewModel())
}
