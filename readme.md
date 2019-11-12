# Yodine
Pronounced Yo-Dine ('Yo-d-eye-ne'?)

# The project
This is made to attempt at emulating a data network from the game StarBase (not out yet)  
its a 2D editor not 3D (as of right now)  

This is heavily work in progress but feedback is always nice.  

Until this project is at a more usable state it might be quite messy, Sorry.

# Controls
Drag with `RMB` to move camera  
Drag with `LMB` to select multiple devices  
Drag with `LMB` on selected device\[s\] to move them  
Click with `LMB` on a device to select single device  
`Ctrl` + `LMB` on a device to add device to selection  
`MMB` on one object then another to connect or disconnect a cable between them  
`Delete` or `X` will remove selected devices, if no devices selected then removes device under cursor  

# Running
To run this you need [love2d](https://love2d.org/)  
To use the provided dll for lpeglabel use 32-bit love2d  
Or just check for any releases and use those instead  

# Some stuff about the repo contents
## grammar.relabel
When editing the grammar i made a vscode extension for fancy colors  
When i get my desktop PC back in the UK i will add my vscode extension for syntax highlighting the grammar file  

## The DLL (lpeglabel.dll)
Its just `LPegLabel` compiled for LuaJIT  
If you don't trust it then feel free to compile it your self (https://github.com/sqmedeiros/lpeglabel)  
or if you have luarocks and it works for LuaJIT then you can use luarocks  
