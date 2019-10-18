# Countdown Tracker - project outline

## models  

### ‘event’  

- dateTime: Date  
- tags: [tag]  
- timeRemaining {computed}  
- granularity: DateFormatter  
  - format??  
- notes: String  
- image: imagedata?  
- notifications: [Date]  
- CONTROLLER  
  - sort(by:)  
  - filter(by:)  
  - delete(event)  
  - archive(event)  
    - place event into separate plist
- post-event notes

### ‘tag’  

- name: string
- id: int
- CONTROLLER
  - archive(tag)
    - place tag into separate plist
  - create(tag)
  - delete(tag)
    - remove references to tags in events
  - rename(tag)

### ‘usersettings’  

- default granularity
  - stretch
- date/time format
  - stretch
- timezone
  - get location? (stretch)
- current sort criteria (remember when reopened)
- default filter criteria (optional)

## alerts

- first priority: alerts
- stretch goal: notifications

## persistence

- plist
  - events
    - main
    - archive
  - tags
    - main
    - archive
- userdefaults

## ui  

- table of events
  - each cell has...
    - event name
    - event image
    - time left to event
- segue to....
  - event detail (normal view)
  - add new event (normal view)
  - settings (table view)
  - sort/filter (modal segue)

## priorities

1. multiple events with countdown timer
2. choose granularity of time per event
3. add tags
4. sort/filter list
5. alert

## stretch goals

1. event/tag archive
2. event images
3. push notifications
4. prompt for post-event reflection notes (prompt on first event; user can turn off)
5. get location
