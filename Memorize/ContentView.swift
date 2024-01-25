//
//  ContentView.swift
//  Memorize
//
//  Created by Ikramuzzaman Muntasir on 23/1/24.
//

import SwiftUI

struct ContentView: View {
    let halloweenEmojis = ["👻", "🎃", "🕷", "😈", "💀", "🕸", "🧙‍♀️", "🙀", "👹", "😱", "☠️", "🍭"]
    let vehicles = ["🚗", "✈️", "🚎", "⛵️", "🚲", "🚂", "🚑", "🚁", "🛵", "🛺", "🚜", "🛴"]
    let sports = ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🎱", "🏏", "🏓", "🏸", "🥊", "🏊"]
    
    @State var emojis: Array<String> = ["👻", "🎃", "🕷", "😈", "💀", "🕸", "🧙‍♀️", "🙀", "👹", "😱", "☠️", "🍭"]
    
    let themeTitle = ["Halloween", "Vehicle", "Sport"]
    let themeImage = ["paintpalette.fill", "car.fill", "sportscourt.fill"]
    @State var themeRevealed: [Bool] = [true, false, false]
    @State var selectedTheme: Int = 0 {
        didSet {
            switch selectedTheme {
            case 0:
                emojis = halloweenEmojis
            case 1:
                emojis = vehicles
            case 2:
                emojis = sports
            default:
                break
            }
        }
    }
    
    
        
    @State var cardCount = 4
    
    
    var body: some View {
        
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
                .fontWeight(.bold)
            ScrollView {
                cards
            }
            themeButtonsAdjuster
            //cardCountAdjusters
        }
        
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
        .font(.largeTitle)
    }
    
    var themeButtonsAdjuster: some View {
        HStack {
            theme1
            Spacer()
            theme2
            Spacer()
            theme3
        }
    }
    
    func themeButtonBuilder(id: Int) -> some View {
        Button(action: {
            themeRevealed[id] = true
            selectedTheme = id
        }, label: {
            VStack {
                Image(systemName: themeRevealed[id] ? themeImage[id] : "questionmark.circle")
                Text(themeRevealed[id] ? themeTitle[id] : "Theme \(id+1)")
            }
            
        })
        
    }
    
    var theme1: some View {
        themeButtonBuilder(id: 0)
    }
    
    var theme2: some View {
        themeButtonBuilder(id: 1)
    }
    
    var theme3: some View {
        themeButtonBuilder(id: 2)
    }
    
    var cardCountAdjusters: some View {
        HStack {

            cardRemover
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
            
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(!(1..<emojis.count).contains(cardCount + offset))
    }
    
    var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    
    var cardAdder: some View {
        cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
    }
}


struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = true
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
