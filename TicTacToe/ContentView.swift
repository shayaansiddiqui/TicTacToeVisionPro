//
//  ContentView.swift
//  TicTacToe
//
//  Created by Shayaan Siddiqui on 7/11/23.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    @StateObject var gameState = GameState()
    var body: some View {
        NavigationSplitView {
            List {
                Text("New Game")
                    .onTapGesture {
                        gameState.resetBoard()
                    }
                Text("High Scores")
                Text("Exit")
            }
            .navigationTitle("Game Options")
        } detail: {
            VStack {
                let borderSize = CGFloat(5)
                Text(gameState.turnText())
                    .font(.title)
                    .bold()
                    .padding()
                Spacer()
                Text(String(format: "Crosses: %d - Nought: %d", gameState.crossScore, gameState.noughtScore))
                    .font(.title)
                    .bold()
                    .padding()
                VStack(spacing: borderSize)
                {
                    ForEach(0...2, id: \.self)
                    {
                        row in
                        HStack(spacing: borderSize)
                        {
                            ForEach(0...2, id: \.self)
                            {
                                column in
                                
                                let cell = gameState.board[row][column]
                                Text(cell.displayTile())
                                    .font(.system(size: 60))
                                    .foregroundColor(cell.tileColor())
                                    .bold()
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
                                    .aspectRatio(1, contentMode: .fit)
                                    .background(Color.white)
                                    .onTapGesture {
                                        gameState.placeTile(row, column)
                                    }
                            }
                        }
                    }
                }
                .background(Color.black)
                .padding()
            }
            .navigationTitle("Content")
            .padding()
            .alert(isPresented: $gameState.showAlert)
            {
                Alert(
                    title: Text(gameState.alertMessage),
                    dismissButton: .default(Text("Okay"))
                    {
                        gameState.resetBoard()
                    }
                )
            }
            
//            Text(String(format: "Nought: %d", gameState.crossScore))
//                .font(.title)
//                .bold()
//                .padding()
        }
    }
}

#Preview {
    ContentView()
}
