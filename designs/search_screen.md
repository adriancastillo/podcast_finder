# Search Screen Design

## Layout

### Header
- **AppBar** with title "PodcastFinder"
- Elevation: 0
- Background: White

### Search Bar
- Full-width TextField with rounded corners (12px radius)
- Placeholder: "Search podcasts..."
- Leading icon: Search icon (magnifying glass)
- Height: 48px
- Margin: 16px horizontal, 16px top

### Results List
- Scrollable ListView
- Each item is a PodcastCard

## PodcastCard Specification

### Structure
- Card with 12px border radius, 1px border (#DEE2E6)
- Padding: 12px all around
- Horizontal layout (Row)

### Left Section - Image
- 80x80px rounded image (8px radius)
- Placeholder: Gray background with podcast icon
- Error state: Same as placeholder

### Right Section - Content
- **Title**: 
  - Font size: 16px
  - Weight: Semi-bold (600)
  - Color: #212529
  - Max lines: 2
  - Ellipsis overflow

- **Publisher**:
  - Font size: 14px
  - Color: #6C757D
  - Max lines: 1
  - Margin top: 4px

- **Description**:
  - Font size: 13px
  - Color: #ADB5BD
  - Max lines: 2
  - Ellipsis overflow
  - Margin top: 8px

- **Chevron Icon**:
  - Right-aligned
  - Color: #ADB5BD

## States

### Loading
- Show CircularProgressIndicator centered

### Empty
- Show message: "No podcasts found"
- Icon: podcasts icon in gray
- Center aligned

### Error
- Show error message with retry button
- Red error icon
- Message describing the error

## Interactions
- Tap on PodcastCard → Navigate to detail screen
- Typing in search → Debounced API call (500ms)