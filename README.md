# Project Proposal for iOS Build Sprint

1. Fork and Clone this repository
2. Fill out the information below (Remove `<placeholders>` and add your answers)
3. Tag your TL and Instructor on your Pull Request

## Requirements

1. Team Members: Christopher Price, Jordan Skenandore
2. App Name: Read A Book
3. App Description (3-5 sentences):

    - Have you ever had a friend recommend a book, but by the time you finally got to the bookstore you forgot the title? Or have you ever taken a break from a book so long that you can't remember where you left off? Well, this app lets you track both! Enter the title of the book you want to read, and then check off each chapter as you read along!
    
4. Your #1 Customer (Who would use your app? Why now?)
 
    We have all picked up the nearest sticky note to hurry and record the name of a book that a friend recomends, just to find the remains of that sticky note in your dryers lint catcher a few days later. This app lets users not only record the title of that book, but also helps you keep your place as you follow along! Anyone who has ever read a book will tell you that it's not a rare thing for life to get in the way somewhere between the first and final page, but with "Read-A-Book" that will no longer be an issue, as it only takes seconds to check the boxes to the chapters you've read, to save your spot till next time!
    
5. Github code repository: https://github.com/iOSPT5-BW1/Binge-Watcher.git
6. Github Project/Trello Board: TL's are currently working on it.
7. Create a Slack DM Group with your partner, TL, and Instructor and say "hi!": DONE AND DONE

## Part 1: Brainstorming

Add photos, notes, and sketches from your brain storming session. 

1. Brainstorming (Photo / Sketch)
    1. Mind Map (15 minutes)
        1. Set a timer for 15 minutes
        2. Grab a piece of paper and write your app name in the center
        3. Add as many ideas and connections (Don't stop early, keep going until the timer ends)
        4. If you still have ideas, reset the timer and do it again
        5. Take a photo of your mind map and upload it to your proposal (YourName-Mindmap.jpg)
    2. Organize a List (15 minutes)
        1. Set a timer for 15 minutes
        2. Make a list on paper (or Markdown) and capture all your ideas from the mindmap
        3. If new ideas appear, write those down too
        4. Take a photo of your organized list and upload it to your proposal (YourName-List.jpg or YourName-List.md)
    3. Prioritize (5 minutes)
        1. What features does your #1 customer need most?
        2. Choose 3-5 features that make the core app experience
        3. Add these features to your `## Top Features` section
    4. Sketch (15 minutes)
        1. Draw a rectangle in the center of a paper
        2. Sketch a rough idea of what buttons, labels, images would be on the screen
        3. Repeat this for 3-5 of your top features
        4. Add annotations to your sketches (i.e.: point out how gesture interactions or animations might work)
        5. Take a photo of each mockup
    5. Share (15 minutes)
        1. Pair up with a fellow student and show them your idea (Screenshare on Zoom)
        2. Take notes and write down any of their ideas
2. If you have tons of ideas, set a timer again and keep going.
3. Don't filter yourself in the brainstorming phase, you want to capture everything and anything

## Top Features (Prioritize)

Add your top 3-5 features (core functionality) from the Prioritize brainstorming step. These should be things that are part of the MVP (not a log in screen). Build for the demo day (i.e.: Apple never shows how to log into the Apple ID on stage).

1) Collection view is the main view controller:
	-books I want to read
	-books I have read
		-“you’ve read this many ” message at the top.
2) Detail view has the chapters and check box.
	-Table View
		-Title
		-Checkbox
	-A way to add books
		-Third view, or Alert, or new tab
	-A way to add chapters (probably just the same view controller as the book adder)
3) Progress Bar- how many chapters you’ve read
	-In the DetailView
-Persistence
-App icon
-Add books
-Delete books/chapters
-Edit chapter notes
Stretch:
-Progress bar in the collection view as well
-“Page you left off on” option - virtual bookmark
-Notes section for chapters
Medium Stretch:
-Add an image for book cover for the Collection View
-Organization options
	-Priority
	-Date added
	-Genre?
Super stretch:
-Different media (via Tab Bar Controller)
	-With a main page based on priority
	-Network/Source
-Networking with family and friends

## Part 2: Project Plan

Take a step away from your computer and go for a walk. Your brain will continue to think about your app idea.

1. Add your tasks to your Kanban board (Github Project/Trello)
2. Be specific in your tasks so that they are actionable.
    1. "Create View Controllers" is vague and isn't clear when you're finished
    2. "Create Table View Controller for GIFCell rows" and "Create Custom GIFTableViewCell" are specific
3. Organize your tasks (Drag and drop)
    1. Break down large tasks into subtasks
    2. If you don't know how to do a task, add to research it (i.e: "Research: AVFoundation Video Thumbnails API" or "Read: Core Graphics Programming Guide")
4. Start on your most difficult task first
5. Re-evaluate your progress each day and plan what you'll work on the next day
