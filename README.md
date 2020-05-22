# Project Proposal for iOS Build Sprint

1. Fork and Clone this repository
2. Fill out the information below (Remove `<placeholders>` and add your answers)
3. Tag your TL and Instructor on your Pull Request

## Requirements

1. Team Members: Wyatt Harrell & Hector Ledesma
2. App Name: Retake: Camera App
3. App Description (3-5 sentences):

    Retake allows users to easily take timelapses of weight gain/loss, building progress, plant growth, or even just a scenic lanscape by superimposing an image with lowered opacity onto its camera. Users can create journal type enties with their photos to keep track of when their photos were taken, the location they were taken in, and much more. A user can also view their photos in a no-animation viewer to see the difference in their images more clearly.
    
4. Your #1 Customer (Who would use your app? Why now?)
 
    Photographers, builders, botanists, the sky is the limit! Any average person can use this app to catalog change!
    
5. Github code repository: `<Create a Github Project>`
6. Github Project/Trello Board: `<Post your link to your Kanban board>`
7. Create a Slack DM Group with your partner, TL, and Instructor and say "hi!"

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

1. Superimposing image over custom camera
    - Grid for better alignment
    - Changing opacity of original image
2. Journal entry catelog
    - Associated photos
    - Location of photo for MapKit
    - ARKit spot in space where photo was taken
    - Notes on either each photo taken or each journal
    - Date of each photo taken
3. Persistance of some kind (CoreData, CloudKit, etc.)
4. Image viewer with no animation to easily see change between photos
5. (Stretch) Image similarity and analysis with feature print, vision framework, photo stacking, etc. 

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
