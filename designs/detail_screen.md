# Podcast Detail Screen Design

## Layout

### Header
- **AppBar** with back button
- Title: Podcast title (truncated if too long)
- Elevation: 0

### Hero Section
- Full-width image (maintains aspect ratio, max height 300px)
- Gradient overlay at bottom for better text contrast

### Content Section (Scrollable)

#### Title & Publisher
- **Title**: 
  - Font size: 24px
  - Weight: Bold (700)
  - Color: #212529
  - Padding: 16px horizontal, 16px top

- **Publisher**:
  - Font size: 16px
  - Color: #6C757D
  - Padding: 8px horizontal

#### Description
- Font size: 15px
- Color: #212529
- Line height: 1.5
- Padding: 16px horizontal

#### Genre Tags
- Horizontal list of chips
- Background: #F1F3F5
- Text color: #6C63FF
- Border radius: 16px
- Padding: 8px 12px
- Margin: 16px horizontal

#### Episodes Section
- **Section Header**:
  - Text: "Recent Episodes"
  - Font size: 18px
  - Weight: Semi-bold (600)
  - Padding: 16px horizontal, 16px top

- **Episode List Item**:
  - Card with 1px border
  - Padding: 12px
  - Margin: 8px horizontal, 8px bottom

  **Episode Title**:
  - Font size: 16px
  - Weight: Medium (500)
  - Color: #212529
  - Max lines: 2

  **Episode Metadata**:
  - Font size: 14px
  - Color: #6C757D
  - Shows: Date published • Duration
  - Format date: "Dec 16, 2023"
  - Format duration: "60 min" or "1h 30m"

## States

### Loading
- Show shimmer skeleton for:
  - Image area
  - Title lines
  - Description lines
  - Episode list items

### Error (Episodes)
- Show error message: "Failed to load episodes"
- Retry button
- Keep podcast info visible

## Interactions
- Back button → Return to search screen
- Tap on episode → Show snackbar "Playback not implemented" (optional)