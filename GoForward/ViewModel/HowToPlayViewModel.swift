//
//  HowToPlayViewModel.swift
//  GoForward
//
//  Created by Ho Le Minh Thach on 25/08/2022.
//

import Foundation
import SwiftUI

final class HowToPlayViewModel: ObservableObject {
    let headers = [
        "Players and Cards",
        "The Deal",
        "The Play",
        "End of the Play"
    ]
    
    let sections = [
        "Players and Cards" : [
            "The game is for four players. A standard 52 card deck is used; there are no Jokers and no wild cards. It is possible for two or three to play. It can also be played by more than four players, using two 52 card packs shuffled together.",
            "The game is normally dealt and played clockwise, but can be played anticlockwise instead if the players agree in advance to do so.",
            "The ranking of the cards is: Two (highest), Ace, King, Queen, Jack, Ten, Nine, Eight, Seven, Six, Five, Four, Three (lowest).",
            "Within each rank there is also an order of suits: Hearts (highest), Diamonds, Clubs, Spades (lowest).",
        ],
        "The Deal" : [
            "For the first game, the dealer is chosen at random; subsequently the loser of each game has to deal the next. When there are four players, 13 cards are dealt to each player.",
            "If there are fewer than four players, 13 cards are still dealt to each player, and there will be some cards left undealt - these are not used in the game. An alternative with three players is, by prior agreement, to deal 17 cards each. When there are only two players, only 13 cards each should be dealt - if all the cards were dealt the players would be able to work out each other's hands, which would spoil the game. When there are more than four players, you can agree in advance either to deal 13 cards each from the double deck, or deal as many cards as possible equally to the players."
        ],
        "The Play" : [
            "In the first game only, the player with the 3 of Spades begins play. If no one has the 3 (in the three or two player game) whoever holds the lowest card begins. The player must begin by playing this lowest card, either on its own or as part of a combination.",
            "Each player in turn must now either beat the previously played card or combination, by playing a card or combination that beats it, or pass and not play any cards. The played card(s) are placed in a heap face up in the centre of the table. The play goes around the table as many times as necessary until someone plays a card or combination that no one else beats. When this happens, all the played cards are set aside, and the person whose play was unbeaten starts again by playing any legal card or combination face up to the centre of the table.",
            "If you pass you are locked out of the play until someone makes a play that no one beats. Only when the cards are set aside and a new card or combination is led are you entitled to play again.",
            """
            The legal plays in the game are as follows:
            - Single card: The lowest single card is the 3 and the highest is the 2.
            - Pair: Two cards of the same rank - such as 7-7 or Q-Q.
            - Three of a kind: Three cards of the same rank - such as 5-5-5
            - Four of a kind: Four cards of the same rank - such as 9-9-9-9.
            - Straight: Three or more cards of consecutive rank (the suits can be mixed) - such as 4-5-6. The straight cannot contains rank 2.
            - Straight in pair: Three or more pairs of consecutive rank - such as 3-3-4-4-5-5 or 6-6-7-7-8-8-9-9. The straight cannot contains rank 2.
            """,
            "In general, a combination can only be beaten by a higher combination of the same type and same number of cards. So if a single card is led, only single cards can be played; if a pair is led only pairs can be played; a three card sequence can only be beaten by a higher three card sequence; and so on.",
            "To decide which of two combinations of the same type is higher you just look at the highest card in the combination.",
            """
            There are just four exceptions to the rule that a combination can only be beaten by a combination of the same type:
            - A four of a kind can beat any single two. A four of a kind can be beaten by a higher four of a kind.
            - A sequence of three pairs (such as 7-7-8-8-9-9) can beat any single two. A sequence of three pairs can be beaten by a higher sequence of three pairs.
            - A sequence of four pairs (such as 5-5-6-6-7-7-8-8) can beat a pair of twos and a single two. A sequence of four pairs can be beaten by a higher sequence of four pairs.
            - A sequence of five pairs (such as 8-8-9-9-10-10-J-J-Q-Q) can beat a set of three twos. A sequence of five pairs can be beaten by a higher sequence of five pairs.
            - Note that these exceptions only apply to beating twos, not other cards. For example, if someone plays an ace you cannot beat it with your four of a kind, but if the ace has been beaten by a two, then your four of a kind can be used to beat the two.
            """
        ],
        "End of the Play" : [
            "As players run out of cards they drop out of the play. If the player whose turn it is to play has no cards left, the turn passes to the next player in rotation. The play ends when there is a player with no cards left."
        ]
    ]
    
    let refLink = Link("Gambiter", destination: URL(string: "https://gambiter.com/cards/climbing/thirteen.html")!)
    let linkedInLink = Link("LinkedIn", destination: URL(string: "https://www.linkedin.com/in/thach-ho-le-minh-a000b3216/")!)
    let githubLink = Link("Github", destination: URL(string: "https://github.com/MichaelHo02")!)

    
    
    func playBGMusic() {
        Sound.play(sound: "SomberRomance", type: "wav", category: .ambient, volume: 1, numberOfLoops: -1, isBackgroundMusic: true)
    }
    
    func stopBGMusic() {
        Sound.stopBGMusic()
    }
}
