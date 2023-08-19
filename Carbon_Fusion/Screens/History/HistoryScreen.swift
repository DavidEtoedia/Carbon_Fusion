//
//  HistoryScreen.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 09/08/2023.
//

import SwiftUI

struct HistoryScreen: View {
    @EnvironmentObject private var supaBaseVm: SupbaseViewModel
    @State private var isSelected: Bool = false
    @State private var showAlert: Bool = false
    @State private var selectedid: String = ""
    let list : [DataModel]
    var body: some View {
        VStack {
            HStack(alignment:.bottom) {
                Text("History")
                    .font(.custom(Font.climateCrisis, size: 35))
                    .foregroundColor(.white)
                Spacer()
                NavigationLink {
                    ChatScreen(list: list)
                } label: {
                    Text("View chart")
                        .font(.system(size:15))
                        .foregroundColor(.blue)
            }
            }
            
            ScrollView(showsIndicators: false) {
                ForEach(list) { value in
                    
                    CarbonHistory(value: value) {
                        if(supaBaseVm.delete.isLoading && value.id.description == selectedid){
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .padding(.vertical, 15)
                        }
                        else{
                            Button {
                                showAlert = true
                                selectedid = value.id.description
                            } label: {
                                Image(systemName: "trash")
                            }

                        }
                    }

                }
              
            }
          
        }
        .alert("Delete Alert", isPresented: $showAlert, actions: {
            HStack {
              
                Button(role: .none, action: {
                    showAlert = false
                    supaBaseVm.delete(id: selectedid.lowercased())
                }, label: {
                    Text("Delete")
                        .foregroundColor(.red)
                })
                Button("Cancel", role: .cancel) {
                    //supaBaseVm.delete(id: selectedid)
                }
            }
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.horizontal, 20)
        .edgesIgnoringSafeArea(.bottom)
    .background(.black)
    }
    
    

}

struct HistoryScreen_Previews: PreviewProvider {
    static var previews: some View {
        HistoryScreen(list: mockResponse)
            .environmentObject(SupbaseViewModel())
    }
}



struct CarbonHistory<Content: View>: View {
    var value: DataModel
    @ViewBuilder let content: () -> Content
    var body: some View {
        
        /*
         
         if(loading){
             ProgressView()
                 .progressViewStyle(CircularProgressViewStyle(tint: .white))
                 .padding(.vertical, 15)
         }
         else{
             Button(action: action) {
                 Image(systemName: "trash")
             }
         }
         */
        HStack {
            HStack {
                VStack(alignment:.leading) {
                    Text(value.name)
                        .foregroundColor(.white)
                    Space(height: 10)
                    Text(value.createdAt.formattedDate)
                        .font(.system(size: 10))
                        .foregroundColor(.white.opacity(0.4))
                }
                Spacer()
                HStack(alignment:.center, spacing: 2) {
                    Text(String(value.carbonKg.rounded(toDecimalPlaces: 1)))
                        .font(.custom(Font.climateCrisis, size: 20))
                        .foregroundColor(.white)
                    
                    Text("Kg")
                        .font(.custom(Font.climateCrisis, size: 10))
                        .foregroundColor(.white)
                }
                
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 10)
            .background{
                Rectangle()
                    .foregroundColor(.gray.opacity(0.15))
            }
            .padding(.vertical, 8)
            Spacer()
            content()
          
            
        }
    }
}
