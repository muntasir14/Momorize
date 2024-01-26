//
//  ContentView.swift
//  Memorize
//
//  Created by Ikramuzzaman Muntasir on 23/1/24.
//

import SwiftUI

struct ContentView: View {
    // These data are used based on chosen theme
    let halloweenEmojis = ["👻", "🎃", "🕷", "😈", "💀", "🕸", "🧙‍♀️", "🙀", "👹", "😱", "☠️", "🍭"]
    let vehicles = ["🚗", "✈️", "🚎", "⛵️", "🚲", "🚂", "🚑", "🚁", "🛵", "🛺", "🚜", "🛴"]
    let sports = ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🎱", "🏏", "🏓", "🏸", "🥊", "🏊"]
    
    
    @State var emojis: Array<String> = []
    
    // Populating and selecting variables
    let themeTitle = ["Halloween", "Vehicle", "Sport"]
    let themeImage = ["paintpalette", "car", "sportscourt"]
    let maxPairCount = 10
    let colors: [Color] = [.orange, .red, .green]
    
    @State var themeRevealed: [Bool] = [false, false, false]
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
            buildRandomEmojis()
        }
    }
    
    
    
    
    var body: some View {
       VStack {
            Text("Memorize!")
                .font(.largeTitle)
                .fontWeight(.bold)
            ScrollView {
                cards
            }
            themeButtonsAdjuster
        }
        
        .padding()
    }
    
    func buildRandomEmojis() {
        let pairsCount = Int.random(in: 2...maxPairCount)
        var tempEmojis = emojis
        emojis = []
        
        for _ in 0..<pairsCount {
            let i = Int.random(in: 0..<tempEmojis.count)
            let icon = tempEmojis[i]
            
            emojis += [icon, icon]
            tempEmojis.remove(at: i)
        }
        
        emojis.shuffle()
    }
    
    var cards: some View {
        
        
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80, maximum: CGFloat(1240)/CGFloat(emojis.count)))]) {
            ForEach(0..<emojis.count, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(colors[selectedTheme])
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
            themeRevealed = themeRevealed.map { _ in false }
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
    
}


struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = false
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
