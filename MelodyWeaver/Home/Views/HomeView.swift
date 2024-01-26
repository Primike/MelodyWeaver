//
//  HomeView.swift
//  MelodyWeaver
//
//  Created by Prince Avecillas on 1/24/24.
//

import SwiftUI

struct HomeView: View {
    @State var showNewScreen = false
    @State private var navigateToNewSong = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(0..<100) { item in
                    NavigationLink(destination: NewSongView(viewModel: SheetMusicViewModel())) {
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
                .swipeActions(edge: .trailing, allowsFullSwipe: false, content: { Button(action: {}, label: {
                    Text("Delete")
                }) })

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
            .sheet(isPresented: $showNewScreen) {
                CreateNewSongView(onCreatePressed: {
                    handleCreatePressed()
                })
            }
            .navigationDestination(isPresented: $navigateToNewSong) {
                NewSongView(viewModel: SheetMusicViewModel())
            }
        }
    }

    private func handleCreatePressed() {
        showNewScreen = false
        Task {
            try? await Task.sleep(nanoseconds: 100_000_000)
            navigateToNewSong = true
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
    HomeView()
}
