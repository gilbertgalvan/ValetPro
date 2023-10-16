//
//  ContentView.swift
//  Valet Pro
//
//  Created by Gilbert Galvan on 9/12/23.
//

import SwiftUI

struct ContentView: View {
    @State private var ticketNumber = 264084
    //@State private var showTicket = false
    @State private var ticketList: [Int] = []
        
    var body: some View {
        
        VStack{
            HStack{
                Spacer()
                Text("Search")
                Spacer()
                Image(systemName:"magnifyingglass")
                Spacer()
                VStack{
                    Image(systemName: "plus.app.fill")
                    Button("New Ticket"){
                        ticketNumber += 1
                        ticketList.insert(ticketNumber, at: 0)
                    }
                }
                Spacer()
            }
            Spacer()
            ForEach(ticketList, id: \.self) { ticket in
                CustomHStackView(ticketNumber: ticket)
                    .border(Color.black,width:2)
                    .padding(5)
            }
        }
    }
    
    struct CustomHStackView: View {
        var ticketNumber: Int
        
        var body: some View {
            HStack {
                Spacer()
                VStack {
                    Text("\(ticketNumber)")
                        .font(.system(size: 25))
                    Text("10/17/23")
                        .font(.system(size: 15))
                }
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Button("Pull") {
                    // Add your action for the "Pull" button here
                }
                Button("Edit") {
                    // Add your action for the "Edit" button here
                }
                .foregroundColor(.green)
                Spacer()
            }
        }
    }
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    
}
