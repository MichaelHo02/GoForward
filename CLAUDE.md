# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview
GoForward is an iOS card game application built with SwiftUI and Core Data. It's a "Go Forward" card game where players compete against AI opponents in a traditional Vietnamese card game format.

Demo: https://youtu.be/W825_8iwxzA

## Architecture
- **Pattern**: MVVM (Model-View-ViewModel) architecture
- **UI Framework**: SwiftUI
- **Data Persistence**: Core Data for leaderboard/user scores
- **Audio**: AVFoundation for sound effects and background music
- **State Management**: ObservableObject and @Published properties for reactive UI updates

## Key Components

### Models
- `GameModel`: Core game logic, card validation, AI player behavior, scoring system
- `Player`: Player entity with hand management and scoring
- `Card`: Card representation with rank, suit, and display properties
- `DeckModel`: Deck creation, shuffling, and card distribution
- `Stack`: Typealias for `[Card]` used throughout the game

### ViewModels
- `GameViewModel`: Main game state management, timer control, player actions
- `PageViewModel`: Navigation between different app screens
- `LeaderboardViewModel`: High score management and display
- `HowToPlayViewModel`: Tutorial and instruction management

### Views
- `ContentView`: Root view with navigation state switching
- `GameView`: Main game interface with player hands and game board
- `MenuView`: Main menu with game options
- `LeaderboardView`: Score history display
- `HowToPlayView`: Game tutorial and rules

### Core Data
- `DataController`: Singleton for Core Data operations
- `User` entity: Stores player names, scores, and win status
- Model file: `Model.xcdatamodeld`

## Development Commands

### Building and Running
```bash
# Build the project
xcodebuild -project GoForward.xcodeproj -scheme GoForward -configuration Debug

# Run on simulator (if iOS Simulator tools are available)
xcodebuild -project GoForward.xcodeproj -scheme GoForward -configuration Debug -destination 'platform=iOS Simulator,name=iPhone 14' 

# Clean build folder
xcodebuild clean -project GoForward.xcodeproj -scheme GoForward
```

### Testing
No automated test suite is currently configured. Testing should be done manually through Xcode simulator or device.

## Game Logic Architecture

### Card Game Rules Implementation
- Traditional Vietnamese "Go Forward" card game
- 4 players (1 human, 3 AI)
- 13 cards per player from standard 52-card deck
- Complex hand validation system with multiple card types:
  - Single cards, Pairs, Three of a kind, Straights
  - Pair-in-straight combinations
  - Four of a kind (special case)

### AI System
- Located in `GameModel.swift:295-372`
- Uses subset generation algorithm to evaluate all possible plays
- Scoring system considers card values and strategic positioning
- AI players have different difficulty levels through evaluation functions

### Sound System
- `Sound.swift` handles all audio playback
- Background music and sound effects for game actions
- Audio files stored in `GoForward/Sound/` directory

## File Organization
- `/GoForward/`: Main source files
- `/Assets.xcassets/`: App icons, card images, color assets
- `/Sound/`: Audio files for game effects
- `Preview Content/`: SwiftUI preview assets

## Important Notes
- Game state is persisted using UserDefaults for resume functionality
- All card images are included as image sets in Assets.xcassets
- The app supports background/foreground state changes with automatic game pausing
- Core Data is used only for leaderboard persistence, not game state
- Sound system supports both ambient background music and effect sounds

## Swift/SwiftUI Patterns Used
- ObservableObject for ViewModels
- @Published properties for reactive updates
- Custom ViewModifiers for animations and transitions
- Timer.publish for game timing mechanics
- UserDefaults for simple data persistence
- Singleton pattern for DataController