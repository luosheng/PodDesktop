//
//  ContainerView.swift
//  PodDesktop
//
//  Created by Luo Sheng on 2021/9/7.
//

import SwiftUI

struct ContainerView: View {
    @ObservedObject var containerStore: ContainerStore
    @State private var sorter = Sorter.none
    @State private var keyword = ""
    
    enum Sorter: String, CaseIterable, Identifiable {
        case none = "None"
        case name = "Name"
        case image = "Image"
        case status = "Status"
        
        var id: Sorter { self }
    }
    
    var sortedContainers: [Container] {
        switch sorter {
        case .name:
            return containerStore.containers.sorted { $0.names > $1.names }
        case .image:
            return containerStore.containers.sorted { $0.image > $1.image }
        case .status:
            return containerStore.containers.sorted { $0.status > $1.status }
        default:
            return containerStore.containers
        }
    }
    
    var filteredContainers: [Container] {
        sortedContainers.filter {
            keyword == "" || $0.names.contains(keyword) || $0.id.contains(keyword)
        }
    }
    
    var body: some View {
        VStack {
            TextField("Search", text: $keyword)
                .padding()
            List() {
                ForEach(filteredContainers) { container in
                    ContainerItem(container: container)
                }
            }
            .listStyle(InsetListStyle())
        }
        .background(Color.white)
        .onAppear(perform: {
            containerStore.fetch()
        })
        .navigationTitle("Containers")
        .toolbar {
            ToolbarItem(placement: .principal) {
                Picker("Sort by", selection: $sorter) {
                    ForEach(Sorter.allCases) { sorter in
                        Text(sorter.rawValue)
                            .tag(sorter)
                    }
                }
            }
        }
        
    }
}

struct ContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ContainerView(containerStore: MockModel().containerStore)
    }
}
