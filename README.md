# Project Proposal for iOS Build Sprint

1. Fork and Clone this repository
2. Fill out the information below (Remove `<placeholders>` and add your answers)
3. Tag your TL and Instructor on your Pull Request

## Requirements

1. Team Members: `just me`
2. App Name: `StartWatch`
3. App Description (3-5 sentences):

```
StartWatch makes time tracking easier and faster. The interface features big, easy-to-identify buttons
that let you switch tasks with a quick glance and only one tap. The companion Apple Watch app allows
you to keep your favorite tasks right on your wrist. And it's even simple to create new tasks on the
fly and worry about entering the details later, so you can focus on your task and not your task tracker.
```
    
4. Your #1 Customer (Who would use your app? Why now?)
 
```
Someone who needs or wants to track the time they spend on various tasks/projects and report on them
later. Anyone who works on multiple contracts or various tasks and needs to charge separetly for
each. Basically people who use Harvest but don't like it.
```
    
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

1. `Create tasks with the ability to choose a color and emoji to represent it, and specify a title. Show the top six tasks as large buttons displaying the color (background) and emoji.`
2. `Show a scrollable list of the remaining tasks. These tasks also display the color and emoji, and also show the title.`
3. `Start timing any task by tapping on it once. The timer starts immediately - no need to stop the previous timer, if any. This will make it super quick to start and also to switch between tasks as you go through your day."
4. `Tap the "Quick task" button to immediately start timing a new task, with the ability to go back later and fill in the details.`
5. `Apple Watch companion app that shows the current task running (just the color, emoji, and elapsed time), and the top 4 tasks. Scrolling down reveals the fifth and sixth top task, followed by the list of remaining tasks. Tap any of them to start timing. Tap an X (or other stop icon) near the running time to stop timing tasks.`
6. `Some basic reporting on task times. How much time for each task that day, for example.`

## Stretch Goals
1. `Better reporting, including exporting reports to a file or email or...?`
2. `Watch complication.`
3. `iPhone widget.`
4. `Format for iPad.`
5. `Sync across devices.`
6. `Voice or speech-to-text memos when adding a Quick Task so that you don't forget why you started it.`

## Future Features
These are features I'd like to add eventually but will almost definitely not have time for this sprint.

1. `Harvest API integration.`
2. `Extra task details, like charge numbers, contract numbers, or whatever else might be useful for the user in a report.`
3. `Voice, speech-to-text, or text notes for all tasks so that you can remember important things that come up while working.`
4. `Mac app.`


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
