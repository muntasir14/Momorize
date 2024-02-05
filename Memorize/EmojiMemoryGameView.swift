//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Ikramuzzaman Muntasir on 23/1/24.
//

import SwiftUI

//let halloweenEmojis = ["👻", "🎃", "🕷", "😈", "💀", "🕸", "🧙‍♀️", "🙀", "👹", "😱", "☠️", "🍭"]
//let vehicles = ["🚗", "✈️", "🚎", "⛵️", "🚲", "🚂", "🚑", "🚁", "🛵", "🛺", "🚜", "🛴"]
//let sports = ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🎱", "🏏", "🏓", "🏸", "🥊", "🏊"]

struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
    // These data are used based on chosen theme
    
    
    
    
    
    var body: some View {
       VStack {
            Text("Memorize!")
                .font(.largeTitle)
                .fontWeight(.bold)
            ScrollView {
                cards
            }
           Button("Shuffle") {
               viewModel.shuffle()
           }
        }
        
        .padding()
    }
    
    
    var cards: some View {
        
        
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards.indices, id: \.self) { index in
                CardView(viewModel.cards[index])
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
            }
        }
        .foregroundColor(.orange)
    }
    
   
    
    
    
    
}


struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        
    }
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
}




struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
