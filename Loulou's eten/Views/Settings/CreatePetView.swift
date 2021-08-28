//
//  CreatePetView.swift
//  CreatePetView
//
//  Created by Wisse Hes on 28/08/2021.
//

import SwiftUI

struct CreatePetView: View {
    
    @StateObject var viewModel = CreatePetViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                HStack {
                    Text("general.name")
                        .bold()
                    
                    Spacer()
                    
                    TextField(LocalizedStringKey("general.name"), text: $viewModel.name)
                        .multilineTextAlignment(.trailing)
                }
                
                HStack {
                    Spacer()
                    Button {
                        viewModel.createPet()
                    } label: {
                        switch viewModel.buttonState {
                        case .normal:
                            Label("general.done", systemImage: "checkmark.circle")
                        
                        case .loading:
                            ProgressView()
                        
                        case .success:
                            Label("general.success", systemImage: "checkmark")
                                .labelStyle(.iconOnly)
                        }
                        
                    }.disabled(viewModel.buttonState == .loading || viewModel.buttonState == .success)
                    
                    Spacer()
                }
            }.navigationTitle("addPet.name")
                .onReceive(viewModel.viewDismissalModePublisher) { output in
                    if output == true {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Label("general.close", systemImage: "xmark.circle")
                        }
                    }
                }
        }
    }
}

struct CreatePetView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePetView()
    }
}