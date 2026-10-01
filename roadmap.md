# Roadmap

### ~Basic Movement~

* ~added basic zero g movement~
* ~added dash~
* ~added statemachine, spacestate, and slidingplayerstate~

### ~The Shooting Part~

* ~add basic weapon model~
* ~weapon resource and initialization~
* ~weapon class script~
* ~add shooting, hit registration, health, dummies~
* ~learn about signals~
* ~general cooldown script, add cooldown for shooting~
* ~sounds, hit effects, tracers~
* ~rocket launcher, projectile spawning in weapon class~
* ~sniper scope so I can go crazy~
* ~clean up shooting code~

### Peer-To-Peer Multiplayer
* ~should be very easy and totally painless (it wasn't)~
* ~create client and server~
* ~network movement~
* ~network weapons~
* ~add and network player damage~
* add basic gamemode (ffa first to 5 (or 10))
* actual map
* clean up networking code before pushing to main

### actual ui
* cooldowns, health? (done but buggy)
* swap weapons on death/spawn
* show score
* persistent player colors on death

### physics cleanup
* round player model
* ~mouse rotation~
* add camera snap
* option for normal 360 camera
* balance movement stats
* make backwards drift go slower
* dash is oomphier when going against momentum

### polish
* movement sounds
* clean up code
* standardize variables
* add local classes
* controls and sens customization
* integrate weaponrig code into state machine (maybe save for later)
* sniper scope with gradient and lines
* make the sky actually dark
* rocket jumping

## ***FIRST PLAYTEST***

* test feel of movement and camera
* make sure nothing explodes
* see how bad my netcode is

### After Playtest

* arm cannon, melee hitboxes in weapon class, animations (maybe)
* artifact and ability classes
* get some abilities down before the second playtest
* Better animations for sliding
* wall grinding, corner hug, and other movement options
* Gravity physics in the far far future
* dedicated server (thank you for volunteering your laptop ozan)
* seperate rendering viewport for the gun
* weapon shadow
* barrel effects
* controls and sens customization
