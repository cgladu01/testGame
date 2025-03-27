class_name ReflectionMirror extends Event


func setup():
    for x in range(0, 3):
        var eventOption = EventOption.new()

        match x:
            0:
                eventOption.setup("Hello", func (): 
                    print("Yo pog")
                    endEvent.emit())
            1:
                eventOption.setup("Smash", func ():
                    print("Woop de do")
                    endEvent.emit())

            2:
                eventOption.setup("Goodbye", func ():
                    print("Not pog")
                    endEvent.emit())
        
        choices.append(eventOption)