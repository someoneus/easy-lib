# Easy Library
Easy Library is a roblox exploit library

This library is Very Simple, easy and well optimized

With both Mobile and PC supports

Below is the full tutorial on how to use it



### Please keep in mind that this is my first library, Expect Bugs 
___
___
___
# Booting up the Library
Before you can do anything you need to put this on the first line of your script!

```
loadstring(game:HttpGet("https://raw.githubusercontent.com/someoneus/easy-lib/refs/heads/main/source.lua"))()
```
---
---
# Creating a Window
This window is the main frame that puts all of your components together!

```
easyCreateWindow("Title")
```

The first argument is a title string, put any string there and it will become your title
---
---

# Creating a Tab
A Tab is like a room to your components, splitting them into groups

```
easyCreateTab("TabName")
```

The First argument is the Tab name put any string there and it will become your Tab name
---
---
# Creating a Button
I made this one very easy to use for you

```
easyCreateButton({
    Name = "Button",
    Callback = function()
        --The function that takes place when the button is clicked

    end
})
```

Below the Callback is your function, put any code there and it should execute on pressed
---
---
# Creating a Toggle

```
easyCreateToggle({
    Name = "Toggle",
    Callback = function(Value)
    -- The function that takes place when toggled on or off

    end
})
```

The argument (Value) is the state of the toggle. True = Toggled On, False = Toggled Off
---
---
# Creating a Label

```
easyCreateLabel("LabelText")
```

Label is just a line of Text that you can change
---
---
# Updating a Label

```
easyUpdateLabel("UpdatedText")
```

Updates your latest created Label
