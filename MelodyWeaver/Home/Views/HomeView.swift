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
                    NavigationLink(destination: NewSongView(viewModel: viewModel.createViewModel(item))) {
                        HStack {
                            Text("\(item.name)")
                                .font(.headline)
                            Spacer()
                            Text("\(item.date)")
                                .foregroundColor(.gray)
                                .font(.caption)
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
                NewSongView(viewModel: viewModel.createNewSong())
            }
        }
    }

    func delete(indexSet: IndexSet) {
        viewModel.deleteSong(indexSet)
    }
    
    func move(indices: IndexSet, newOffset: Int) {
        viewModel.moveSongOrder(indices: indices, newOffset: newOffset)
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
